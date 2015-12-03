# -*- coding: utf-8 -*-
require 'matrix'

a = Array.new
p a

v1 = Vector[1,2,3]
v2 = Vector[2,4,8]

a.push(v1)
p a
a.push(v2)
p a

p a.size

#ベクトルのすべての要素にスカラーの加算をする
p v1.map { |x|
  x + 1
}

count=1
daihyo = {}
a.size.times do
  daihyo[count.to_s] = a[count-1]
  count += 1
end

p daihyo

=begin
class LVQ
  def initialize(ambassador) #代表ベクトルを初期値として受け取る
  end
end
=end
