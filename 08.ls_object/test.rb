# frozen_string_literal: true

require 'list_to_columns'

words = %w[
  antipyic
  baccheion
  conormal
  diet
  extracloacal
  fadridden
  germifuge
  hovering
  isomerical
  jagrata
  knuclesome
  libidinal
  myoclonic
  nonunionism
  overmarl
  parochialization
  quadriparous
  radiotelegraph
  sobby
  tailpipe
  undefectiveness
  vintaging
  wheaten
  xanthydrol
  yesso
  zircofluoride
]

puts ListToColumns.new(words, width: 60, space: 3)
