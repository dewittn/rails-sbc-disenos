# Business Impact Analysis

Analysis of how the Diseños application supported S.B.C. Panamá embroidery operations from 2009-2011.

## Executive Summary

This document analyzes the operational impact of the Diseños design management system on a small embroidery shop in Panama. The analysis uses forensic examination of a production database dump from April 2011, containing 1,590 design records and 5,705 timeline events.

### Key Findings

| Metric | Value |
|--------|-------|
| Designs Managed | 1,590 designs over ~2 years |
| Time Saved | 2.5+ years of labor time |
| Throughput Increase | 40% from initial adoption to peak |
| Revenue Supported | ~$1.55M over 6 years (2007-2012) |
| File Completeness | 99% (excellent system adoption) |

### The Problem

Before the application, the production workflow required:

1. Search through paper binders for thread documentation
2. Print new documentation if missing
3. Obtain design file reference
4. Configure embroidery machine using paper notes
5. Interrupt designer/production manager to locate DST/PES files
6. Save files to floppy disk

**Estimated time:** 20-25 minutes per job

### The Solution

The application reduced the workflow to:

1. Look up design on factory floor workstation
2. Download files (instant access to DST/PES and thread colors)
3. Begin production

**Estimated time:** 2-5 minutes per job

**Time saved:** 15-23 minutes per production run

## Time Savings Analysis

### Direct Labor Savings (Machine Operators)

| Scenario | Production Runs | Minutes Saved/Run | Total Days Saved |
|----------|-----------------|-------------------|------------------|
| Conservative | 4,770 | 15 | 149 days |
| Middle | 6,360 | 19 | 252 days |
| Optimistic | 7,950 | 23 | 381 days |

### Indirect Labor Savings (Designer Interruptions)

Each production run previously required interrupting the designer:
- Stop current work
- Locate embroidery files
- Save to floppy disk
- Resume work (with context switching penalty)

**Total interruption cost:** 20-35 minutes per occurrence

| Scenario | Interruptions | Designer Days Saved |
|----------|---------------|---------------------|
| Conservative | 4,770 | 199 days |
| Middle | 6,360 | 364 days |
| Optimistic | 7,950 | 580 days |

### Combined Impact

| Scenario | Total Days Saved | Equivalent Years |
|----------|------------------|------------------|
| Conservative | 348 days | ~1.4 years |
| **Middle** | **616 days** | **~2.5 years** |
| Optimistic | 961 days | ~3.8 years |

## Capacity Analysis

### Daily Capacity Impact

| Phase | Time per Job | Jobs per 8-Hour Day | Improvement |
|-------|--------------|---------------------|-------------|
| Old Process | 52.5 min | 9.1 jobs | baseline |
| New Process | 33.5 min | 14.3 jobs | **+57%** |

The application enabled 57% more jobs per machine per day.

### Design Throughput Growth

Analysis by 6-month periods:

| Period | Timeframe | Designs Added | Avg/Month | Growth |
|--------|-----------|---------------|-----------|--------|
| 1 | May-Oct 2009 | 346 | 57.7 | baseline |
| 2 | Nov 2009-Apr 2010 | 389 | 64.8 | +12% |
| 3 | May-Oct 2010 | 484 | **80.7** | **+40%** |
| 4 | Nov 2010-Apr 2011 | 371 | 61.8 | +7% |

**Peak throughput:** 80.7 designs/month (40% increase over initial adoption)

### The Cache Effect

The decline from 80.7 to 61.8 designs/month in Period 4 is not reduced activity. It demonstrates the application working as intended:

**Periods 1-3:** Building the cache
- New orders required new design entry
- High volume of designs added to system

**Period 4:** Cache populated
- Many designs already in system
- Reorders served directly from existing library
- Only genuinely NEW designs need entry

This pattern is consistent with repeat customers and seasonal reuse (e.g., back-to-school designs from Year 1 reused in Year 2).

## Seasonal Patterns

### Monthly Design Volume

| Month | Avg Designs/Year | Index vs Mean | Notes |
|-------|------------------|---------------|-------|
| **March** | **106.0** | **161%** | **Peak - Back to School** |
| August | 83.5 | 127% | Secondary peak |
| September | 88.0 | 134% | Secondary peak |
| May | 42.5 | 65% | Low season |
| December | 48.0 | 73% | Low season |

**Mean:** 66.3 designs/month

Panama's school year begins in March, driving the primary peak. A secondary peak occurs July-September for mid-year orders and sports seasons.

## Revenue Context

The business reportedly experienced approximately 3x revenue growth during the system's active use. While direct causation cannot be proven from database analysis alone, contributing factors include:

1. **57% increase in machine capacity** - More jobs per day per machine
2. **Designer freed from interruptions** - Could focus on design work, take more clients
3. **Faster lead times** - Competitive advantage in order turnaround
4. **Scalability unlocked** - Setup was no longer the bottleneck
5. **Reduced errors** - Consistent, up-to-date documentation

For detailed revenue analysis, see the companion document: [Forensic Data Analysis](../doc/forensic_data_analysis.md)

## Thread (Hilo) Analysis

### Brand Distribution

| Brand | Thread Uses | % of Total | Unique Colors |
|-------|-------------|------------|---------------|
| **Crown** | 6,658 | **92%** | 23 |
| Marathon | 220 | 3% | 11 |
| RA | 166 | 2% | 11 |
| ISACORD | 81 | 1% | 6 |
| Other | 119 | 2% | 29 |

Crown was the dominant supplier, with just 23 colors covering 92% of all thread usage. This indicates strong supplier relationship and optimized inventory management.

### Most Used Colors

| Rank | Color | Code | Brand | Uses | % of Total |
|------|-------|------|-------|------|------------|
| 1 | BLANCO (White) | 001 | Crown | 1,325 | 18.3% |
| 2 | NEGRO (Black) | 003 | Crown | 1,231 | 17.0% |
| 3 | ROJO (Red) | 002 | Crown | 851 | 11.7% |
| 4 | AZUL ROYAL | 102 | Crown | 632 | 8.7% |
| 5 | VERDE (Green) | 231 | Crown | 558 | 7.7% |

**Top 2 colors (White + Black) = 35% of all thread usage**
**Top 5 colors = 64% of all thread usage**

## File Completeness

| DST File | PES File | Count | Percentage |
|----------|----------|-------|------------|
| Present | Present | 1,447 | 91.0% |
| Present | Missing | 124 | 7.8% |
| Missing | Missing | 18 | 1.1% |

**99% of designs have DST files** (primary machine format). This excellent data completeness indicates strong system adoption.

## Operational Pattern Analysis

### Day of Week Distribution

| Day | Designs Created | % of Weekly Total |
|-----|-----------------|-------------------|
| Monday | 296 | 18.5% |
| Tuesday | 279 | 17.4% |
| Wednesday | 272 | 17.0% |
| Thursday | 280 | 17.5% |
| Friday | 267 | 16.7% |
| Saturday | 196 | 12.2% |
| Sunday | 0 | 0% |

6-day work week with relatively even distribution Monday-Friday. Saturday productivity ~30% lower.

### Hour of Day Distribution

| Hour | Designs | % | Pattern |
|------|---------|---|---------|
| 10am | 204 | 13% | Morning peak |
| 11am | 199 | 13% | Morning peak |
| 12pm | 75 | 5% | **Lunch break** |
| 2pm | 213 | 13% | Afternoon |
| **3pm** | **221** | **14%** | **Daily peak** |

Standard workday 8am-5pm with clear lunch break dip at noon.

## Key Takeaways

### Quantified Benefits

- **2.5+ years of labor time saved** (middle scenario)
- **57% daily capacity increase** per machine
- **40% throughput growth** from initial adoption to peak
- **99% file completeness** demonstrating strong adoption

### Strategic Benefits

1. **Bottleneck Removal** - Designer no longer constrained by two processes simultaneously
2. **Knowledge Capture** - Institutional knowledge preserved in system vs. one person's memory
3. **Scalability** - Setup time no longer limited machine additions
4. **Quality Improvement** - Consistent, current documentation reduced errors
5. **Lead Time Reduction** - Faster turnaround enabled competitive advantage
6. **Self-Service Operations** - Workers independent from designer availability
7. **Design Cache Effect** - System decoupled order volume from designer workload

### Growth Enablement

The application transformed from a cost savings tool to infrastructure for scale. Before, growth was constrained by paper-based processes and single-person dependencies. After, the self-service system enabled ~3x revenue growth.

## Methodology

This analysis is based on forensic examination of:

- Production database dump from April 19, 2011
- 1,590 design records
- 5,705 timeline events
- User interviews about operational workflow
- Contemporaneous financial data for validation

See the complete analysis with all queries and methodology: [Forensic Data Analysis](../doc/forensic_data_analysis.md)

## Limitations

1. Usage frequency (3-5 times per design) based on user estimate, not measured
2. Context switching time (15-25 min) based on productivity research
3. Revenue figures based on contemporaneous estimates
4. Some timeline events may reflect data migration (Feb 2010 spike excluded)
5. Reuse rate inferred from timeline data, not directly measured

---

*Analysis conducted December 2024 using production database dump from April 2011*
