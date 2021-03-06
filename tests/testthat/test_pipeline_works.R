

test_that('Same output when seed set and input the same', {
  library(HiCcompare)
  library(testthat)
  data('HMEC.chr22')
  data('NHEK.chr22')
  tab1 = HiCcompare::create.hic.table(HMEC.chr22, NHEK.chr22, chr = 'chr22')
  tab2 = HiCcompare::create.hic.table(HMEC.chr22, NHEK.chr22, chr = 'chr22')
  set.seed(1)
  norm1 = HiCcompare::hic_loess(tab1)
  norm1 = HiCcompare::hic_compare(norm1)
  set.seed(1)
  norm2 = HiCcompare::hic_loess(tab2)
  norm2 = HiCcompare::hic_compare(norm2)
  expect_equal(norm1, norm2)
})


test_that('Pipeline works', {
  library(HiCcompare)
  library(testthat)
  data('HMEC.chr22')
  data('NHEK.chr22')
  tab = HiCcompare::create.hic.table(HMEC.chr22, NHEK.chr22, chr = 'chr22')
  set.seed(1)
  norm1 = HiCcompare::hic_loess(tab)
  norm2 = HiCcompare::hic_compare(norm1)
  norm5 = HiCcompare::hic_compare(norm1, A.min = 5,  Plot = F)
  expect_equal(class(norm1)[1], "data.table")
  expect_equal(class(norm2)[1], "data.table")
  expect_equal(class(norm5)[1], "data.table")
  expect_error(hic_compare(norm1, A.min = 0))
  expect_error(hic_compare(norm1, A.quantile = 2))
  expect_error(hic_compare(norm1, A.quantile = -1))
})


# test_that('Settings for hic_loess work', {
#   library(HiCdiff)
#   data('HMEC.chr22')
#   data('NHEK.chr22')
#   tab = create.hic.table(HMEC.chr22, NHEK.chr22, chr = 'chr22')
#   norm = hic_loess(tab, span = 0.05)
#   #norm = hic_loess(tab, span = 1)
#   #norm = hic_loess(tab, span = 2, Plot = T)
#   norm = hic_loess(tab, loess.criterion = 'aicc', Plot= T)
#
# })




