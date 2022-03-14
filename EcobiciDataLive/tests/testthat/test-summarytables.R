context('Summary tables')

Ecobici <-  try(readRDS('./data/Ecobici_test.rds'))

test_that('Function creates correct tables', {
  if(isTRUE(class(Ecobici) == 'try-error')) testthat::skip('Previous Function Failed - skipping summary tables test')

  Ecobici <- CreateTables(Ecobici)
  expect_length(Ecobici, 3)
  expect_named(Ecobici$summaryTables, c('use_by_gender',
                                        'use_by_gender_per',
                                        'tiempo_uso'))
})
