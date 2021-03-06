require(quanteda)
require(stringi)

test_that("test that yaml do not contain illegal letters", {

    dir <- '../dict/'
    for (f in list.files(dir, pattern = 'yml')) {
        l <- readLines(paste0(dir, f))
        expect_true(all(stri_count_fixed(l, ';') == 0))
        expect_true(all(stri_count_charclass(l, "\\p{Z}") == stri_count_fixed(l, " ")))
        expect_true(all(stri_count_charclass(l, "\\p{C}") == 0))
    }

})


test_that("test that data file is created correctly", {

    expect_equal(lengths(names(data_dictionary_newsmap_en)), 5)
    expect_equal(lengths(names(data_dictionary_newsmap_de)), 5)
    expect_equal(lengths(names(data_dictionary_newsmap_es)), 5)
    expect_equal(lengths(names(data_dictionary_newsmap_ja)), 5)
})

test_that("test that dictionaries have the same countries", {

    en <- names(quanteda:::flatten_dictionary(data_dictionary_newsmap_en, 3))
    de <- names(quanteda:::flatten_dictionary(data_dictionary_newsmap_de, 3))
    es <- names(quanteda:::flatten_dictionary(data_dictionary_newsmap_es, 3))
    ja <- names(quanteda:::flatten_dictionary(data_dictionary_newsmap_ja, 3))

    expect_true(identical(en, de))
    expect_true(identical(en, es))
    expect_true(identical(en, ja))

})
