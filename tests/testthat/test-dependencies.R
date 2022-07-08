test_that("abort_packages_not_installed works", {
  testfun <- function(...) abort_packages_not_installed(...)
  expect_null(testfun("utils"))
  expect_error(
    testfun("not_a_package"),
    "The following package\\(s\\) are required for `testfun\\(\\)` but are not installed:"
  )
  expect_error(
      abort_packages_not_installed('also-not-a-package'),
      "The following package\\(s\\) are required"
  )
})
