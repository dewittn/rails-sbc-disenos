// Handle missing images by showing a placeholder
(function() {
  // Determine appropriate placeholder based on image path
  function getPlaceholder(src) {
    // Check if it's an original (client artwork) or design (embroidery) image
    if (src.indexOf('/originals/') !== -1) {
      return '/images/missing_original_medium.png';
    } else if (src.indexOf('/small/') !== -1) {
      return '/images/missing_design_small.png';
    } else {
      return '/images/missing_design_medium.png';
    }
  }

  // Check if an image is a system upload that needs fallback handling
  function isSystemImage(src) {
    return src && src.indexOf('/system/') !== -1;
  }

  // Replace broken image with placeholder
  function handleBrokenImage(img) {
    var src = img.attr('src') || img.attr('data-original-src');
    if (isSystemImage(src) && !img.data('fallback-applied')) {
      img.data('fallback-applied', true);
      img.attr('data-original-src', src);
      img.attr('src', getPlaceholder(src));
    }
  }

  // Check if image failed to load (works for already-failed images)
  function checkImageLoaded(imgElement) {
    var img = $(imgElement);
    var src = img.attr('src');

    if (!isSystemImage(src)) return;

    // If image is complete but has no dimensions, it failed to load
    if (imgElement.complete) {
      if (imgElement.naturalWidth === 0 || imgElement.naturalHeight === 0) {
        handleBrokenImage(img);
      }
    }
  }

  $(document).ready(function() {
    // Check all existing images (handles images that failed before JS loaded)
    $('img').each(function() {
      checkImageLoaded(this);

      // Also attach error handler for future errors
      $(this).on('error', function() {
        handleBrokenImage($(this));
      });
    });

    // For dynamically loaded images (AJAX)
    $(document).on('error', 'img', function() {
      handleBrokenImage($(this));
    });
  });

  // Also run on window load to catch any stragglers
  $(window).on('load', function() {
    $('img').each(function() {
      checkImageLoaded(this);
    });
  });
})();
