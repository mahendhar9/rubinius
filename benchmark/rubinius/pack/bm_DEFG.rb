require 'benchmark'

total = (ENV['TOTAL'] || 50_000).to_i

S = [1.0e+17, 1.0e+18, 10000000000.8858, 1.0e+14, 100000000.689154,
     1000000.73936503, 1.0e+17, 10000000000000.9, 10000.4873356698,
     10.4823945794373]
M = [1000.57492741949, 100000000.432819, 10000000.0499371, 1000000.52037837,
     10000.6924514925, 1000000.49291029, 10000000000.3365, 1000.66037892185,
     100000.546584181, 10000000.104377, 1.0e+14, 1.39129441498929,
     1000000000.42013, 100.615936978513, 10000000000.5111, 1000000000000.61,
     10000.3964158672, 1000000.20999904, 1.0e+15, 1.0e+19, 100000.602395747,
     100.849277951265, 10000000000.9691, 10000.9340485931, 1.0e+14]
L = [10000000000.3963, 1000.15391121554, 10000.2368409929, 10000000.7260586,
     1.0e+19, 1.0e+19, 1.53702668827636, 1.0e+19, 1000.99536018718, 1.0e+18,
     10000000000000.5, 10000000000.6147, 10000000000.5131, 10.6705327778506,
     1000000000000.03, 100000000000.786, 1.73843946555012, 1000000000000.0,
     1.7543191149827, 1.0e+17, 1.0e+15, 1.0e+19, 1.0e+15, 1.0e+14,
     10000000000.8715, 10000000000000.7, 10000000000.0245, 1.0e+16,
     10.8884362163885, 1000000000.95139, 100000.928022346, 1.0e+19,
     10000000000.5899, 100000000000.107, 10000000.4865695, 100.567855510993,
     1.00000000000001e+14, 100000000.729698, 1.0e+16, 1.21126268366431, 1.0e+19,
     1.0e+16, 10000000.0454655, 10.7347715810549, 1.0e+15, 1.0e+17,
     10000000000.917, 10000000.1581092, 1000000000.07828, 10000000.5379263]
X = [1.0e+15, 10000000000.6975, 10000.2579536687, 1.0e+14, 1.0e+18,
     100000000000.523, 1.00000000000001e+14, 1000000000000.73, 1.0e+17,
     10.6484231938761, 1000000000.62581, 100000000000.372, 100000000000.151,
     100000.519429489, 1.0e+19, 1.0e+16, 100000000000.688, 100000000.646713,
     10.8675408335189, 1.0e+18, 10000000000.4101, 100000000000.025, 1.0e+16,
     10000.4423359387, 1000000000.49052, 1.0e+15, 10.4423734656544,
     100.908036591746, 1000000000.76355, 100000000000.507, 10000.6028574808,
     100000.278115849, 100000000.615578, 1.0e+19, 1000000.81754291,
     1000000000000.41, 10.8982285002967, 1000.05989291537, 1.0e+16,
     100000.782766867, 100.594561308053, 100.000512468131, 100000000000.17,
     1.0e+19, 100.519255773701, 1.88845594313687, 1.0e+15, 1.0e+19,
     1000000.37229409, 1.0e+17, 1000000000.0589, 1000.61311012897,
     10000.9722332728, 1000000000.52923, 10000000000.4745, 100000.399834164,
     1.0e+14, 10000.6797514741, 1.0e+18, 10000000.6911092, 1.0e+18,
     100000000.682741, 1000000.1719724, 10000000000.5487, 10000000.6459486,
     1000000000000.71, 1.0e+19, 1.0e+17, 10000000000000.2, 1.0e+16, 1.0e+18,
     1.0e+16, 1.0e+15, 100000000.297004, 1.0e+18, 100000.547362854,
     10000000000000.7, 1.0e+15, 1000000000.2081, 10000000000000.1,
     1000000000.34349, 1.0e+15, 1.0e+16, 1.63639885787428, 1.0e+15,
     1.00000000000001e+14, 10000000000000.9, 1.0e+16, 1000000000.2427,
     10000000.5649076, 1000000.2233057, 1000000000000.34, 1.0e+19,
     1.83235790242839, 10000.3899410308, 1.0e+15, 10000000.760846,
     1.29793123214085, 10000000.4640746, 100.143671645458, 10000000000.3735,
     10000.8626418923, 1000000000.27607, 10000.5791310971, 1.84245400303814,
     1.0e+19, 100000.232353674, 100000000000.0, 1.0e+15, 100.998581253703,
     100000000000.197, 1.8639566010423, 1.0e+17, 1000000000.21047,
     100.37540211495, 100000000.896406, 10000.3961030561, 10000000000000.9,
     100000.143700482, 100000.835144427, 1000.56108980676, 100.324561357775,
     100000.419459238, 1.00000000000001e+14, 1000000000.28656, 1000000.93560016,
     10000.9608733827, 1.0e+19, 1.0e+19, 1.0e+14, 10.2528365967521,
     1.11665664424512, 100000000.77759, 1.24299585207751, 100000.932486674,
     1.0e+19, 100000000.840431, 100000000000.105, 100000000.755943,
     10.1393636133333, 1.0e+16, 1000000000.15268, 100.66158905747,
     1000000000.75199, 100000000000.816, 1000000.35999334, 1.0e+15,
     1000000.50325135, 10000000000.0479, 1000000000000.43, 1000.86451068342,
     100000.267209034, 1.00000000000001e+14, 1000000.79924823, 10.9757039963447,
     1.0e+15, 100000000000.465, 100.412074111112, 10.1763646734913,
     10000000.2395712, 1.0e+17, 1.0e+16, 10000000000000.1, 1.0e+18,
     1.00000000000001e+14, 1.0e+16, 100000000.036154, 1000000000.3829,
     100000000000.204, 1.0e+14, 100000.628021212, 1.0e+17, 10000000000.0226,
     10.2158341922596, 10000000000000.7, 1.0e+16, 1.0e+15, 1000000.58384957,
     1.0e+15, 10000000.0868284, 1.0e+19, 1000000.37995833, 1.0e+18,
     100000000000.346, 1.0e+14, 1000000000000.56, 1.0e+14, 100000000000.256,
     1000000000.28473, 10000000000.9809, 1.0e+16, 1000000000000.33,
     1000000000.20532, 10000000.7341617, 100000000000.411, 1.0e+17,
     1.00000000000001e+14, 1.0e+15, 1.00000000000001e+14, 1.0e+15,
     10000000000000.8, 10000000000.9725, 10.0164322367102, 1.0e+17,
     10000000.984113, 10000000000000.4, 10000000000.1577, 10000000000000.1,
     1000.99805149372, 1000000000000.38, 1.0e+19, 1.53207117870842, 1.0e+15,
     100.303838870775, 1.0e+18, 10000000000.1678, 10000000000.0726,
     1.00000000000001e+14, 1000.17409228258, 1000000000000.76, 100000000000.425,
     10000000000.3242, 1.0e+19, 100000.533407675, 10.6037850608451, 1.0e+17,
     1000.85061679644, 1.0e+18, 10000000.9203455, 10.1924856307005,
     10000000000.5402, 10000.6200800785, 1.0e+16, 100000000000.392,
     10.5981988484124, 1.0e+16, 10000000.4196978, 1.0e+19, 1000.05633508145,
     1.0e+16, 1.0e+15, 1.00000000000001e+14, 1.0e+14, 1000000.98824626,
     10.7642377136609, 10000.3851845047, 1.0e+15, 1.07778529220987, 1.0e+16,
     100000000000.804, 100.75500786576, 1000000000000.07, 10.5144752053575,
     10000.9660250602, 1.0e+14]

Benchmark.bmbm do |x|
  x.report("loop") do
    total.times { 1 }
  end

  x.report("[S].pack('D')") do
    total.times { S.pack("D") }
  end

  x.report("[S].pack('d')") do
    total.times { S.pack("d") }
  end

  x.report("[S].pack('E')") do
    total.times { S.pack("E") }
  end

  x.report("[S].pack('e')") do
    total.times { S.pack("e") }
  end

  x.report("[S].pack('F')") do
    total.times { S.pack("F") }
  end

  x.report("[S].pack('f')") do
    total.times { S.pack("f") }
  end

  x.report("[S].pack('G')") do
    total.times { S.pack("G") }
  end

  x.report("[S].pack('g')") do
    total.times { S.pack("g") }
  end

  x.report("[S].pack('D*')") do
    total.times { S.pack("D*") }
  end

  x.report("[S].pack('d*')") do
    total.times { S.pack("d*") }
  end

  x.report("[S].pack('E*')") do
    total.times { S.pack("E*") }
  end

  x.report("[S].pack('e*')") do
    total.times { S.pack("e*") }
  end

  x.report("[S].pack('F*')") do
    total.times { S.pack("F*") }
  end

  x.report("[S].pack('f*')") do
    total.times { S.pack("f*") }
  end

  x.report("[S].pack('G*')") do
    total.times { S.pack("G*") }
  end

  x.report("[S].pack('g*')") do
    total.times { S.pack("g*") }
  end

  x.report("[M].pack('D*')") do
    total.times { M.pack("D*") }
  end

  x.report("[M].pack('d*')") do
    total.times { M.pack("d*") }
  end

  x.report("[M].pack('E*')") do
    total.times { M.pack("E*") }
  end

  x.report("[M].pack('e*')") do
    total.times { M.pack("e*") }
  end

  x.report("[M].pack('F*')") do
    total.times { M.pack("F*") }
  end

  x.report("[M].pack('f*')") do
    total.times { M.pack("f*") }
  end

  x.report("[M].pack('G*')") do
    total.times { M.pack("G*") }
  end

  x.report("[M].pack('g*')") do
    total.times { M.pack("g*") }
  end

  x.report("[L].pack('D*')") do
    total.times { L.pack("D*") }
  end

  x.report("[L].pack('d*')") do
    total.times { L.pack("d*") }
  end

  x.report("[L].pack('E*')") do
    total.times { L.pack("E*") }
  end

  x.report("[L].pack('e*')") do
    total.times { L.pack("e*") }
  end

  x.report("[L].pack('F*')") do
    total.times { L.pack("F*") }
  end

  x.report("[L].pack('f*')") do
    total.times { L.pack("f*") }
  end

  x.report("[L].pack('G*')") do
    total.times { L.pack("G*") }
  end

  x.report("[L].pack('g*')") do
    total.times { L.pack("g*") }
  end

  x.report("[X].pack('D*')") do
    total.times { X.pack("D*") }
  end

  x.report("[X].pack('d*')") do
    total.times { X.pack("d*") }
  end

  x.report("[X].pack('E*')") do
    total.times { X.pack("E*") }
  end

  x.report("[X].pack('e*')") do
    total.times { X.pack("e*") }
  end

  x.report("[X].pack('F*')") do
    total.times { X.pack("F*") }
  end

  x.report("[X].pack('f*')") do
    total.times { X.pack("f*") }
  end

  x.report("[X].pack('G*')") do
    total.times { X.pack("G*") }
  end

  x.report("[X].pack('g*')") do
    total.times { X.pack("g*") }
  end
end