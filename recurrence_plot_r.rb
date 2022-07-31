require 'numo/narray'
require 'numo/gnuplot'

def recurrence_plot(s, eps=0.1, steps=10)
  st = Numo::NArray[s].transpose
  d = (s - st).abs
  d = (d / eps).floor
  d[d > steps] = steps
  d
end

Numo.gnuplot do
  reset
  set term: "png", size:[800, 800]
  set out: "recurrence_plot_rb.png"
  set xrange: 0..1000
  set yrange: 1000..0
  set title: "sine wave"
  set size: :square
  
  sin_m = Numo::NMath.sin(Numo::DFloat.linspace(0, 6*Math::PI, 1000))
  dist_m = recurrence_plot(sin_m, 0.1, 10)
  plot dist_m, with:"image"
end
