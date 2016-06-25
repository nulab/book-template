CHAPTER_COUNT=2

set datafile separator ","

set xdata time
set timefmt "%Y/%m/%d"
set format x "%Y/%m/%d"

set xrange [:"2016/06/30"] # limit date
set yrange [0:3000]        # avarage character counts per chapter
set xtics 86400*5          # tick by 5day
set grid ytics

set key left top

set terminal png
set out "book-count.png"

plot for [i=1:CHAPTER_COUNT] sprintf("writing-support/count_chapter%d.dat", i) using 1:2 title "chapter".i with lines
