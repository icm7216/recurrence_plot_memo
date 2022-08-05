require 'numo/narray'
require 'numo/gnuplot'

def recurrence_plot(s, eps=0.1, steps=10)
  st = Numo::NArray[s].transpose
  d = (s - st).abs
  d = (d / eps).floor
  d[d > steps] = steps
  d
end

theta = Numo::DFloat.linspace(0, 6*Math::PI, 1000)
dist_m = recurrence_plot(Numo::NMath.sin(theta), 0.1, 10)

Numo.gnuplot do
  reset
  set term: "png", size:[600, 600]
  set out: "recurrence_plot_rb.png"
  set xrange: 0..1000
  set yrange: 1000..0
  set title: "sine wave"
  set size: :square
  set palette_defined:'(0"#440154",1"#472c7a",2"#3b518b",3"#2c718e",4"#21908d",5"#27ad81",6"#5cc863",7"#aadc32",8"#fde725")'
  unset :colorbox
  
  plot dist_m, with:"image"
end
