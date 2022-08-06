require 'numo/narray'
require 'numo/gnuplot'

def recurrence_plot(s, eps=0.1, steps=10)
  st = Numo::NArray[s].transpose
  d = (s - st).abs
  d = (d / eps).floor
  d[d > steps] = steps
  d
end

coef = [0.5, 1, 2, 4]

dist_m = coef.map do |n|
  npi = n * Math::PI
  theta = Numo::DFloat.linspace(-npi, npi, 1000)
  recurrence_plot(Numo::NMath.sinc(theta))  
end

Numo.gnuplot do
  reset
  unset :key
  set term: "png", size:[800, 800]
  set out: "rp_sinc_rb.png"
  set multiplot:{layout: [2,2]}
  set xrange: 0..1000
  set yrange: 1000..0
  set size: :square
  set palette_defined:'(0"#440154",1"#472c7a",2"#3b518b",3"#2c718e",4"#21908d",5"#27ad81",6"#5cc863",7"#aadc32",8"#fde725")'
  unset :colorbox
  set :noxtics
  set :noytics
  
  coef.each_with_index do |n, idx|
    set title: "sinc #{n.to_s} pi"
    plot dist_m[idx], with:"image"
  end

  unset :multiplot
end