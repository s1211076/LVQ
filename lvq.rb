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
    @data = Hash.new{|h,key| h[key]=[]} #同一キーに値を格納するための宣言
    #プロット点の集合　{key=>ラベル　value=>座標}　最初はすべてのラベルをf(不明)で登録
    @size = amb.size #代表ベクトルが格納されている配列の大きさ(ベクトル数)
    #ハッシュに格納　｛key:”カウント” => value:ベクトル}
    @size.times do
      @daihyo[count.to_s] = amb[count-1]
      count += 1
    end
  end

  #指定した代表ベクトル全体にスカラーの加算をする
  def kasan(sukara,rabel)
    tmp = Array.new
    puts"key[#{rabel}]のベクトル全てに#{sukara}を加算します\n"
    @daihyo[rabel.to_s].map { |x|
      tmp.push(x+1)
    }
    v = Vector.elements(tmp,true)
    @daihyo.store(rabel.to_s,v)  #指定したキーの値を変更
  end

  #プロット点を生成
  def make_plot
    file = File.open("plot.txt","w+")
    file1 = File.open("a.txt","w+")
    file2 = File.open("b.txt","w+")
    file3 = File.open("c.txt","w+")
    zahyo = Array.new
    rand1 = Random.new
    count = 1
    150.times do
      if count < 51 then
        zahyo.push(rand1.rand(10.0 .. 40.0))
        zahyo.push(rand1.rand(1.0 .. 35.0))
        file1.puts "#{zahyo[0]} #{zahyo[1]}\n"
      elsif count < 101 then
        zahyo.push(rand1.rand(1.0 .. 25.0))
        zahyo.push(rand1.rand(75.0 .. 100.0))
        file2.puts "#{zahyo[0]} #{zahyo[1]}\n"
      else 
        zahyo.push(rand1.rand(50.0 .. 100.0))
        zahyo.push(rand1.rand(30.0 .. 80.0))
        file3.puts "#{zahyo[0]} #{zahyo[1]}\n"
      end
      file.puts "#{zahyo[0]} #{zahyo[1]}\n"
      vect = Vector.elements(zahyo,true)
      @data["f"] << vect    #同一キーに値を追加する時は=ではなく<<を使う
      zahyo.clear #配列を空にする(破壊的メソッド)
      count += 1
    end
    file.close
    file1.close
    file2.close
    file3.close
  end

  #代表ベクトルを表示
  def print
    p @daihyo
  end
end

#-------------------------------------main-------------------------------
amb=Array.new
v1=Vector[1,3,5]
v2=Vector[2,4,6]
amb.push(v1)
amb.push(v2)

lvq = LVQ.new(amb)
lvq.make_plot
lvq.print
