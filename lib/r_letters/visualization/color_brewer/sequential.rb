# frozen_string_literal: true

module RLetters
  module Visualization
    # Color ramps from the ColorBrewer color palettes
    #
    # These are drawn from ColorBrewer, www.ColorBrewer.org, by Cynthia A.
    # Brewer, Geography, Pennsylvania State University.
    #
    # Copyright (c) 2002 Cynthia Brewer, Mark Harrower, and The Pennsylvania
    # State University.
    #
    # Licensed under the Apache License, Version 2.0 (the "License"); you may
    # not use this file except in compliance with the License. You may obtain
    # a copy of the License at
    #
    # http://www.apache.org/licenses/LICENSE-2.0
    #
    # Unless required by applicable law or agreed to in writing, software
    # distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and
    # limitations under the License.
    #
    # In particular, these were adapted from Mike Bostock's bl.ocks.org code
    # listing: http://bl.ocks.org/mbostock/5577023
    # rubocop:disable ModuleLength
    module ColorBrewer
      # The sequential color schemes
      #
      # From the ColorBrewer page:
      #
      # Sequential schemes are suited to ordered data that progress from low to
      # high. Lightness steps dominate the look of these schemes, with light
      # colors for low data values to dark colors for high data values.
      SEQUENTIAL_COLOR_SCHEMES = {
        3 => {
          'YellowGreen' => ['#f7fcb9', '#addd8e', '#31a354'],
          'YellowGreenBlue' => ['#edf8b1', '#7fcdbb', '#2c7fb8'],
          'GreenBlue' => ['#e0f3db', '#a8ddb5', '#43a2ca'],
          'BlueGreen' => ['#e5f5f9', '#99d8c9', '#2ca25f'],
          'PurpleBlueGreen' => ['#ece2f0', '#a6bddb', '#1c9099'],
          'PurpleBlue' => ['#ece7f2', '#a6bddb', '#2b8cbe'],
          'BluePurple' => ['#e0ecf4', '#9ebcda', '#8856a7'],
          'RedPurple' => ['#fde0dd', '#fa9fb5', '#c51b8a'],
          'PurpleRed' => ['#e7e1ef', '#c994c7', '#dd1c77'],
          'OrangeRed' => ['#fee8c8', '#fdbb84', '#e34a33'],
          'YellowOrangeRed' => ['#ffeda0', '#feb24c', '#f03b20'],
          'YellowOrangeBrown' => ['#fff7bc', '#fec44f', '#d95f0e'],
          'Purples' => ['#efedf5', '#bcbddc', '#756bb1'],
          'Blues' => ['#deebf7', '#9ecae1', '#3182bd'],
          'Greens' => ['#e5f5e0', '#a1d99b', '#31a354'],
          'Oranges' => ['#fee6ce', '#fdae6b', '#e6550d'],
          'Reds' => ['#fee0d2', '#fc9272', '#de2d26'],
          'Greys' => ['#f0f0f0', '#bdbdbd', '#636363']
        },
        4 => {
          'YellowGreen' => ['#ffffcc', '#c2e699', '#78c679', '#238443'],
          'YellowGreenBlue' => ['#ffffcc', '#a1dab4', '#41b6c4', '#225ea8'],
          'GreenBlue' => ['#f0f9e8', '#bae4bc', '#7bccc4', '#2b8cbe'],
          'BlueGreen' => ['#edf8fb', '#b2e2e2', '#66c2a4', '#238b45'],
          'PurpleBlueGreen' => ['#f6eff7', '#bdc9e1', '#67a9cf', '#02818a'],
          'PurpleBlue' => ['#f1eef6', '#bdc9e1', '#74a9cf', '#0570b0'],
          'BluePurple' => ['#edf8fb', '#b3cde3', '#8c96c6', '#88419d'],
          'RedPurple' => ['#feebe2', '#fbb4b9', '#f768a1', '#ae017e'],
          'PurpleRed' => ['#f1eef6', '#d7b5d8', '#df65b0', '#ce1256'],
          'OrangeRed' => ['#fef0d9', '#fdcc8a', '#fc8d59', '#d7301f'],
          'YellowOrangeRed' => ['#ffffb2', '#fecc5c', '#fd8d3c', '#e31a1c'],
          'YellowOrangeBrown' => ['#ffffd4', '#fed98e', '#fe9929', '#cc4c02'],
          'Purples' => ['#f2f0f7', '#cbc9e2', '#9e9ac8', '#6a51a3'],
          'Blues' => ['#eff3ff', '#bdd7e7', '#6baed6', '#2171b5'],
          'Greens' => ['#edf8e9', '#bae4b3', '#74c476', '#238b45'],
          'Oranges' => ['#feedde', '#fdbe85', '#fd8d3c', '#d94701'],
          'Reds' => ['#fee5d9', '#fcae91', '#fb6a4a', '#cb181d'],
          'Greys' => ['#f7f7f7', '#cccccc', '#969696', '#525252']
        },
        5 => {
          'YellowGreen' => ['#ffffcc', '#c2e699', '#78c679', '#31a354',
                            '#006837'],
          'YellowGreenBlue' => ['#ffffcc', '#a1dab4', '#41b6c4', '#2c7fb8',
                                '#253494'],
          'GreenBlue' => ['#f0f9e8', '#bae4bc', '#7bccc4', '#43a2ca',
                          '#0868ac'],
          'BlueGreen' => ['#edf8fb', '#b2e2e2', '#66c2a4', '#2ca25f',
                          '#006d2c'],
          'PurpleBlueGreen' => ['#f6eff7', '#bdc9e1', '#67a9cf', '#1c9099',
                                '#016c59'],
          'PurpleBlue' => ['#f1eef6', '#bdc9e1', '#74a9cf', '#2b8cbe',
                           '#045a8d'],
          'BluePurple' => ['#edf8fb', '#b3cde3', '#8c96c6', '#8856a7',
                           '#810f7c'],
          'RedPurple' => ['#feebe2', '#fbb4b9', '#f768a1', '#c51b8a',
                          '#7a0177'],
          'PurpleRed' => ['#f1eef6', '#d7b5d8', '#df65b0', '#dd1c77',
                          '#980043'],
          'OrangeRed' => ['#fef0d9', '#fdcc8a', '#fc8d59', '#e34a33',
                          '#b30000'],
          'YellowOrangeRed' => ['#ffffb2', '#fecc5c', '#fd8d3c', '#f03b20',
                                '#bd0026'],
          'YellowOrangeBrown' => ['#ffffd4', '#fed98e', '#fe9929', '#d95f0e',
                                  '#993404'],
          'Purples' => ['#f2f0f7', '#cbc9e2', '#9e9ac8', '#756bb1', '#54278f'],
          'Blues' => ['#eff3ff', '#bdd7e7', '#6baed6', '#3182bd', '#08519c'],
          'Greens' => ['#edf8e9', '#bae4b3', '#74c476', '#31a354', '#006d2c'],
          'Oranges' => ['#feedde', '#fdbe85', '#fd8d3c', '#e6550d', '#a63603'],
          'Reds' => ['#fee5d9', '#fcae91', '#fb6a4a', '#de2d26', '#a50f15'],
          'Greys' => ['#f7f7f7', '#cccccc', '#969696', '#636363', '#252525']
        },
        6 => {
          'YellowGreen' => ['#ffffcc', '#d9f0a3', '#addd8e', '#78c679',
                            '#31a354', '#006837'],
          'YellowGreenBlue' => ['#ffffcc', '#c7e9b4', '#7fcdbb', '#41b6c4',
                                '#2c7fb8', '#253494'],
          'GreenBlue' => ['#f0f9e8', '#ccebc5', '#a8ddb5', '#7bccc4',
                          '#43a2ca', '#0868ac'],
          'BlueGreen' => ['#edf8fb', '#ccece6', '#99d8c9', '#66c2a4',
                          '#2ca25f', '#006d2c'],
          'PurpleBlueGreen' => ['#f6eff7', '#d0d1e6', '#a6bddb', '#67a9cf',
                                '#1c9099', '#016c59'],
          'PurpleBlue' => ['#f1eef6', '#d0d1e6', '#a6bddb', '#74a9cf',
                           '#2b8cbe', '#045a8d'],
          'BluePurple' => ['#edf8fb', '#bfd3e6', '#9ebcda', '#8c96c6',
                           '#8856a7', '#810f7c'],
          'RedPurple' => ['#feebe2', '#fcc5c0', '#fa9fb5', '#f768a1',
                          '#c51b8a', '#7a0177'],
          'PurpleRed' => ['#f1eef6', '#d4b9da', '#c994c7', '#df65b0',
                          '#dd1c77', '#980043'],
          'OrangeRed' => ['#fef0d9', '#fdd49e', '#fdbb84', '#fc8d59',
                          '#e34a33', '#b30000'],
          'YellowOrangeRed' => ['#ffffb2', '#fed976', '#feb24c', '#fd8d3c',
                                '#f03b20', '#bd0026'],
          'YellowOrangeBrown' => ['#ffffd4', '#fee391', '#fec44f', '#fe9929',
                                  '#d95f0e', '#993404'],
          'Purples' => ['#f2f0f7', '#dadaeb', '#bcbddc', '#9e9ac8', '#756bb1',
                        '#54278f'],
          'Blues' => ['#eff3ff', '#c6dbef', '#9ecae1', '#6baed6', '#3182bd',
                      '#08519c'],
          'Greens' => ['#edf8e9', '#c7e9c0', '#a1d99b', '#74c476', '#31a354',
                       '#006d2c'],
          'Oranges' => ['#feedde', '#fdd0a2', '#fdae6b', '#fd8d3c', '#e6550d',
                        '#a63603'],
          'Reds' => ['#fee5d9', '#fcbba1', '#fc9272', '#fb6a4a', '#de2d26',
                     '#a50f15'],
          'Greys' => ['#f7f7f7', '#d9d9d9', '#bdbdbd', '#969696', '#636363',
                      '#252525']
        },
        7 => {
          'YellowGreen' => ['#ffffcc', '#d9f0a3', '#addd8e', '#78c679',
                            '#41ab5d', '#238443', '#005a32'],
          'YellowGreenBlue' => ['#ffffcc', '#c7e9b4', '#7fcdbb', '#41b6c4',
                                '#1d91c0', '#225ea8', '#0c2c84'],
          'GreenBlue' => ['#f0f9e8', '#ccebc5', '#a8ddb5', '#7bccc4',
                          '#4eb3d3', '#2b8cbe', '#08589e'],
          'BlueGreen' => ['#edf8fb', '#ccece6', '#99d8c9', '#66c2a4',
                          '#41ae76', '#238b45', '#005824'],
          'PurpleBlueGreen' => ['#f6eff7', '#d0d1e6', '#a6bddb', '#67a9cf',
                                '#3690c0', '#02818a', '#016450'],
          'PurpleBlue' => ['#f1eef6', '#d0d1e6', '#a6bddb', '#74a9cf',
                           '#3690c0', '#0570b0', '#034e7b'],
          'BluePurple' => ['#edf8fb', '#bfd3e6', '#9ebcda', '#8c96c6',
                           '#8c6bb1', '#88419d', '#6e016b'],
          'RedPurple' => ['#feebe2', '#fcc5c0', '#fa9fb5', '#f768a1',
                          '#dd3497', '#ae017e', '#7a0177'],
          'PurpleRed' => ['#f1eef6', '#d4b9da', '#c994c7', '#df65b0',
                          '#e7298a', '#ce1256', '#91003f'],
          'OrangeRed' => ['#fef0d9', '#fdd49e', '#fdbb84', '#fc8d59',
                          '#ef6548', '#d7301f', '#990000'],
          'YellowOrangeRed' => ['#ffffb2', '#fed976', '#feb24c', '#fd8d3c',
                                '#fc4e2a', '#e31a1c', '#b10026'],
          'YellowOrangeBrown' => ['#ffffd4', '#fee391', '#fec44f', '#fe9929',
                                  '#ec7014', '#cc4c02', '#8c2d04'],
          'Purples' => ['#f2f0f7', '#dadaeb', '#bcbddc', '#9e9ac8', '#807dba',
                        '#6a51a3', '#4a1486'],
          'Blues' => ['#eff3ff', '#c6dbef', '#9ecae1', '#6baed6', '#4292c6',
                      '#2171b5', '#084594'],
          'Greens' => ['#edf8e9', '#c7e9c0', '#a1d99b', '#74c476', '#41ab5d',
                       '#238b45', '#005a32'],
          'Oranges' => ['#feedde', '#fdd0a2', '#fdae6b', '#fd8d3c', '#f16913',
                        '#d94801', '#8c2d04'],
          'Reds' => ['#fee5d9', '#fcbba1', '#fc9272', '#fb6a4a', '#ef3b2c',
                     '#cb181d', '#99000d'],
          'Greys' => ['#f7f7f7', '#d9d9d9', '#bdbdbd', '#969696', '#737373',
                      '#525252', '#252525']
        },
        8 => {
          'YellowGreen' => ['#ffffe5', '#f7fcb9', '#d9f0a3', '#addd8e',
                            '#78c679', '#41ab5d', '#238443', '#005a32'],
          'YellowGreenBlue' => ['#ffffd9', '#edf8b1', '#c7e9b4', '#7fcdbb',
                                '#41b6c4', '#1d91c0', '#225ea8', '#0c2c84'],
          'GreenBlue' => ['#f7fcf0', '#e0f3db', '#ccebc5', '#a8ddb5',
                          '#7bccc4', '#4eb3d3', '#2b8cbe', '#08589e'],
          'BlueGreen' => ['#f7fcfd', '#e5f5f9', '#ccece6', '#99d8c9',
                          '#66c2a4', '#41ae76', '#238b45', '#005824'],
          'PurpleBlueGreen' => ['#fff7fb', '#ece2f0', '#d0d1e6', '#a6bddb',
                                '#67a9cf', '#3690c0', '#02818a', '#016450'],
          'PurpleBlue' => ['#fff7fb', '#ece7f2', '#d0d1e6', '#a6bddb',
                           '#74a9cf', '#3690c0', '#0570b0', '#034e7b'],
          'BluePurple' => ['#f7fcfd', '#e0ecf4', '#bfd3e6', '#9ebcda',
                           '#8c96c6', '#8c6bb1', '#88419d', '#6e016b'],
          'RedPurple' => ['#fff7f3', '#fde0dd', '#fcc5c0', '#fa9fb5',
                          '#f768a1', '#dd3497', '#ae017e', '#7a0177'],
          'PurpleRed' => ['#f7f4f9', '#e7e1ef', '#d4b9da', '#c994c7',
                          '#df65b0', '#e7298a', '#ce1256', '#91003f'],
          'OrangeRed' => ['#fff7ec', '#fee8c8', '#fdd49e', '#fdbb84',
                          '#fc8d59', '#ef6548', '#d7301f', '#990000'],
          'YellowOrangeRed' => ['#ffffcc', '#ffeda0', '#fed976', '#feb24c',
                                '#fd8d3c', '#fc4e2a', '#e31a1c', '#b10026'],
          'YellowOrangeBrown' => ['#ffffe5', '#fff7bc', '#fee391', '#fec44f',
                                  '#fe9929', '#ec7014', '#cc4c02', '#8c2d04'],
          'Purples' => ['#fcfbfd', '#efedf5', '#dadaeb', '#bcbddc', '#9e9ac8',
                        '#807dba', '#6a51a3', '#4a1486'],
          'Blues' => ['#f7fbff', '#deebf7', '#c6dbef', '#9ecae1', '#6baed6',
                      '#4292c6', '#2171b5', '#084594'],
          'Greens' => ['#f7fcf5', '#e5f5e0', '#c7e9c0', '#a1d99b', '#74c476',
                       '#41ab5d', '#238b45', '#005a32'],
          'Oranges' => ['#fff5eb', '#fee6ce', '#fdd0a2', '#fdae6b', '#fd8d3c',
                        '#f16913', '#d94801', '#8c2d04'],
          'Reds' => ['#fff5f0', '#fee0d2', '#fcbba1', '#fc9272', '#fb6a4a',
                     '#ef3b2c', '#cb181d', '#99000d'],
          'Greys' => ['#ffffff', '#f0f0f0', '#d9d9d9', '#bdbdbd', '#969696',
                      '#737373', '#525252', '#252525']
        },
        9 => {
          'YellowGreen' => ['#ffffe5', '#f7fcb9', '#d9f0a3', '#addd8e',
                            '#78c679', '#41ab5d', '#238443', '#006837',
                            '#004529'],
          'YellowGreenBlue' => ['#ffffd9', '#edf8b1', '#c7e9b4', '#7fcdbb',
                                '#41b6c4', '#1d91c0', '#225ea8', '#253494',
                                '#081d58'],
          'GreenBlue' => ['#f7fcf0', '#e0f3db', '#ccebc5', '#a8ddb5',
                          '#7bccc4', '#4eb3d3', '#2b8cbe', '#0868ac',
                          '#084081'],
          'BlueGreen' => ['#f7fcfd', '#e5f5f9', '#ccece6', '#99d8c9',
                          '#66c2a4', '#41ae76', '#238b45', '#006d2c',
                          '#00441b'],
          'PurpleBlueGreen' => ['#fff7fb', '#ece2f0', '#d0d1e6', '#a6bddb',
                                '#67a9cf', '#3690c0', '#02818a', '#016c59',
                                '#014636'],
          'PurpleBlue' => ['#fff7fb', '#ece7f2', '#d0d1e6', '#a6bddb',
                           '#74a9cf', '#3690c0', '#0570b0', '#045a8d',
                           '#023858'],
          'BluePurple' => ['#f7fcfd', '#e0ecf4', '#bfd3e6', '#9ebcda',
                           '#8c96c6', '#8c6bb1', '#88419d', '#810f7c',
                           '#4d004b'],
          'RedPurple' => ['#fff7f3', '#fde0dd', '#fcc5c0', '#fa9fb5',
                          '#f768a1', '#dd3497', '#ae017e', '#7a0177',
                          '#49006a'],
          'PurpleRed' => ['#f7f4f9', '#e7e1ef', '#d4b9da', '#c994c7',
                          '#df65b0', '#e7298a', '#ce1256', '#980043',
                          '#67001f'],
          'OrangeRed' => ['#fff7ec', '#fee8c8', '#fdd49e', '#fdbb84',
                          '#fc8d59', '#ef6548', '#d7301f', '#b30000',
                          '#7f0000'],
          'YellowOrangeRed' => ['#ffffcc', '#ffeda0', '#fed976', '#feb24c',
                                '#fd8d3c', '#fc4e2a', '#e31a1c', '#bd0026',
                                '#800026'],
          'YellowOrangeBrown' => ['#ffffe5', '#fff7bc', '#fee391', '#fec44f',
                                  '#fe9929', '#ec7014', '#cc4c02', '#993404',
                                  '#662506'],
          'Purples' => ['#fcfbfd', '#efedf5', '#dadaeb', '#bcbddc', '#9e9ac8',
                        '#807dba', '#6a51a3', '#54278f', '#3f007d'],
          'Blues' => ['#f7fbff', '#deebf7', '#c6dbef', '#9ecae1', '#6baed6',
                      '#4292c6', '#2171b5', '#08519c', '#08306b'],
          'Greens' => ['#f7fcf5', '#e5f5e0', '#c7e9c0', '#a1d99b', '#74c476',
                       '#41ab5d', '#238b45', '#006d2c', '#00441b'],
          'Oranges' => ['#fff5eb', '#fee6ce', '#fdd0a2', '#fdae6b', '#fd8d3c',
                        '#f16913', '#d94801', '#a63603', '#7f2704'],
          'Reds' => ['#fff5f0', '#fee0d2', '#fcbba1', '#fc9272', '#fb6a4a',
                     '#ef3b2c', '#cb181d', '#a50f15', '#67000d'],
          'Greys' => ['#ffffff', '#f0f0f0', '#d9d9d9', '#bdbdbd', '#969696',
                      '#737373', '#525252', '#252525', '#000000']
        }
      }.freeze
    end
    # rubocop:enable ModuleLength
  end
end
