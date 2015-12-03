# -*- coding: utf-8 -*-
require 'matrix'


#メモ(動作確認含む)
=begin
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

---------------配列をベクトルにする-------------
a = [1, 2, 3, 4]
v1 = Vector.elements(a, true)   trueなら複製(元の配列をいじってもv１に影響なし)
v2 = Vector.elements(a, false)　falseなら複製しない(元の配列をいじるとv２にも影響する)
p v1        #=> Vector[1, 2, 3, 4]
p v2        #=> Vector[1, 2, 3, 4]
a[0] = -1
p v1        #=> Vector[1, 2, 3, 4]
p v2        #=> Vector[-1, 2, 3, 4]
----------------------------------------------
=end
#ここまではメモ代わり

#---------------------------------class----------------------------------
class LVQ
  
  def initialize(amb) #代表ベクトル(渡されるときは配列)を初期値として受け取る
    count = 1
    @daihyo = {} # 代表ベクトルを格納するハッシュ
    @size = amb.size #代表ベクトルが格納されている配列の大きさ(ベクトル数)
    #ハッシュに格納　｛key:”カウント” => value:ベクトル}
    @size.times do
      @daihyo[count.to_s] = amb[count-1]
      count += 1
    end
  end

  def kasan(sukara,rabel) #指定した代表ベクトル全体にスカラーの加算をする
    tmp = Array.new
    puts"key[#{rabel}]のベクトル全てに#{sukara}を加算します\n"
    @daihyo[rabel.to_s].map { |x|
      tmp.push(x+1)
    }
    v = Vector.elements(tmp,true)
    @daihyo.store(rabel.to_s,v)  #指定したキーの値を変更
  end


  def print
    p @daihyo
  end
end

#-------------------------------------main-------------------------------
amb = Array.new
v1=Vector[1,3,5]
v2=Vector[2,4,6]
amb.push(v1)
amb.push(v2)

lvq = LVQ.new(amb)
lvq.print
lvq.kasan(1,1)
lvq.print
