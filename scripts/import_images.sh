#!/bin/bash
#
# Import Images Script for Hilos App
#
# This script imports original image files into the Rails Paperclip directory structure.
# It reads the database to find expected filenames and creates the necessary thumbnails.
#
# Usage:
#   ./scripts/import_images.sh <source_directory>
#
# The source directory should contain the original image files.
# The script will match files by name to database records.
#
# Requirements:
#   - ImageMagick (magick command)
#   - Docker Compose running (for database access)
#
# File Types:
#   - image: Embroidery design images (thumbnails: medium 300x300, small 100x100)
#   - original: Client artwork (thumbnails: medium 300x300)
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
RAILS_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PUBLIC_SYSTEM="$RAILS_ROOT/public/system"
DB_CONTAINER="rails-sbc-disenos-db-1"
DB_NAME="hilos_development"
DB_USER="root"
DB_PASS="password"

# Check requirements
check_requirements() {
    if ! command -v magick &> /dev/null; then
        echo -e "${RED}Error: ImageMagick (magick) is required but not installed.${NC}"
        echo "Install with: brew install imagemagick"
        exit 1
    fi

    if ! docker ps | grep -q "$DB_CONTAINER"; then
        echo -e "${RED}Error: Docker container $DB_CONTAINER is not running.${NC}"
        echo "Start with: docker-compose up -d"
        exit 1
    fi
}

# Query database for image info
get_image_info() {
    docker exec -i "$DB_CONTAINER" mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -N -e "$1" 2>/dev/null
}

# Create directory structure and thumbnails for an image attachment
process_image() {
    local id="$1"
    local filename="$2"
    local source_file="$3"
    local attachment_type="$4"  # "images" or "originals"

    local dest_dir="$PUBLIC_SYSTEM/$attachment_type/$id"

    echo -e "${YELLOW}Processing $attachment_type for design #$id: $filename${NC}"

    # Create directories
    mkdir -p "$dest_dir/original"
    mkdir -p "$dest_dir/medium"

    # Copy original
    cp "$source_file" "$dest_dir/original/$filename"

    # Create medium thumbnail (300x300)
    magick "$source_file" -resize 300x300 "$dest_dir/medium/$filename"

    # For design images, also create small thumbnail
    if [ "$attachment_type" = "images" ]; then
        mkdir -p "$dest_dir/small"
        magick "$source_file" -resize 100x100 "$dest_dir/small/$filename"
    fi

    echo -e "${GREEN}  ✓ Created thumbnails for $filename${NC}"
}

# Main import function
import_from_directory() {
    local source_dir="$1"
    local imported=0
    local skipped=0
    local not_found=0

    echo ""
    echo "=========================================="
    echo "Hilos Image Import Script"
    echo "=========================================="
    echo ""
    echo "Source directory: $source_dir"
    echo "Destination: $PUBLIC_SYSTEM"
    echo ""

    # Get all image records from database
    echo "Fetching image records from database..."

    # Process design images (image attachment)
    echo ""
    echo "--- Processing Design Images ---"
    while IFS=$'\t' read -r id filename; do
        if [ -z "$filename" ] || [ "$filename" = "NULL" ]; then
            continue
        fi

        # Look for the file (case-insensitive search)
        local source_file=$(find "$source_dir" -maxdepth 3 -iname "$filename" -type f 2>/dev/null | head -1)

        if [ -n "$source_file" ]; then
            # Check if already imported
            if [ -f "$PUBLIC_SYSTEM/images/$id/original/$filename" ]; then
                echo -e "  Skipping design #$id (already exists)"
                ((skipped++))
            else
                process_image "$id" "$filename" "$source_file" "images"
                ((imported++))
            fi
        else
            echo -e "  ${RED}Not found: $filename (design #$id)${NC}"
            ((not_found++))
        fi
    done < <(get_image_info "SELECT id, image_file_name FROM disenos WHERE image_file_name IS NOT NULL")

    # Process original images (original attachment)
    echo ""
    echo "--- Processing Original (Client) Images ---"
    while IFS=$'\t' read -r id filename; do
        if [ -z "$filename" ] || [ "$filename" = "NULL" ]; then
            continue
        fi

        # Look for the file (case-insensitive search)
        local source_file=$(find "$source_dir" -maxdepth 3 -iname "$filename" -type f 2>/dev/null | head -1)

        if [ -n "$source_file" ]; then
            # Check if already imported
            if [ -f "$PUBLIC_SYSTEM/originals/$id/original/$filename" ]; then
                echo -e "  Skipping original #$id (already exists)"
                ((skipped++))
            else
                process_image "$id" "$filename" "$source_file" "originals"
                ((imported++))
            fi
        else
            echo -e "  ${RED}Not found: $filename (original #$id)${NC}"
            ((not_found++))
        fi
    done < <(get_image_info "SELECT id, original_file_name FROM disenos WHERE original_file_name IS NOT NULL")

    echo ""
    echo "=========================================="
    echo "Import Complete"
    echo "=========================================="
    echo -e "${GREEN}Imported: $imported${NC}"
    echo -e "${YELLOW}Skipped (existing): $skipped${NC}"
    echo -e "${RED}Not found: $not_found${NC}"
    echo ""
}

# Import a single image by design ID
import_single() {
    local design_id="$1"
    local source_file="$2"
    local attachment_type="${3:-images}"  # Default to "images"

    if [ ! -f "$source_file" ]; then
        echo -e "${RED}Error: Source file not found: $source_file${NC}"
        exit 1
    fi

    # Get filename from database
    local db_field="image_file_name"
    [ "$attachment_type" = "originals" ] && db_field="original_file_name"

    local filename=$(get_image_info "SELECT $db_field FROM disenos WHERE id = $design_id")

    if [ -z "$filename" ] || [ "$filename" = "NULL" ]; then
        echo -e "${YELLOW}Warning: No $db_field in database for design #$design_id${NC}"
        echo "Using source filename instead..."
        filename=$(basename "$source_file")
    fi

    process_image "$design_id" "$filename" "$source_file" "$attachment_type"
}

# Show usage
usage() {
    echo "Usage: $0 <command> [options]"
    echo ""
    echo "Commands:"
    echo "  import <source_directory>    Import all matching images from directory"
    echo "  single <id> <file> [type]    Import single image for design ID"
    echo "                               type: 'images' (default) or 'originals'"
    echo "  list                         List expected files from database"
    echo ""
    echo "Examples:"
    echo "  $0 import ~/old_hilos_backup/public/system"
    echo "  $0 single 2 ~/Downloads/TORTUGA.PNG images"
    echo "  $0 single 10 ~/Downloads/GREEN_SERVICES.JPG originals"
    echo "  $0 list"
    echo ""
}

# List expected files
list_expected() {
    echo "Expected Design Images (image_file_name):"
    echo "=========================================="
    get_image_info "SELECT id, image_file_name FROM disenos WHERE image_file_name IS NOT NULL ORDER BY id LIMIT 50"
    echo ""
    echo "(showing first 50, total: $(get_image_info "SELECT COUNT(*) FROM disenos WHERE image_file_name IS NOT NULL"))"
    echo ""
    echo "Expected Original Images (original_file_name):"
    echo "=========================================="
    get_image_info "SELECT id, original_file_name FROM disenos WHERE original_file_name IS NOT NULL ORDER BY id LIMIT 50"
    echo ""
    echo "(showing first 50, total: $(get_image_info "SELECT COUNT(*) FROM disenos WHERE original_file_name IS NOT NULL"))"
}

# Main
check_requirements

case "${1:-}" in
    import)
        if [ -z "${2:-}" ]; then
            echo -e "${RED}Error: Source directory required${NC}"
            usage
            exit 1
        fi
        if [ ! -d "$2" ]; then
            echo -e "${RED}Error: Directory not found: $2${NC}"
            exit 1
        fi
        import_from_directory "$2"
        ;;
    single)
        if [ -z "${2:-}" ] || [ -z "${3:-}" ]; then
            echo -e "${RED}Error: Design ID and source file required${NC}"
            usage
            exit 1
        fi
        import_single "$2" "$3" "${4:-images}"
        ;;
    list)
        list_expected
        ;;
    *)
        usage
        exit 1
        ;;
esac
