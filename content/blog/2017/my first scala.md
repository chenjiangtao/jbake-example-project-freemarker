title=我的第一个scala程序
date= 09/12/2017 
type=post
tags=blog scala
status=published
~~~~~~

帮同事处理`List[scala.collection.immutable.Map[String,Any]]`的排序问题
原来想的办法是
```
var x = mylist.sortWith(_.get("commonCount").toString > _.get("commonCount").toString)
```
`_.get("commonCount")`可以取出值，但类型是 `Some`,要用`_.get("commonCount").get` 来获取真实类型
```
scala> println(mylist.map(_.get("commonCount").get.getClass))
List(class java.lang.Integer, class java.lang.Integer, class java.lang.Integer, class java.lang.Integer, class java.lang.Integer)
```
知道真实的数据类型，但在实际使用时要转换成基本类型`.asInstanceOf[Int]`，进行判断
```
mylist.sortWith((x, y) => x.get("commonCount").get.asInstanceOf[Int] < y.get("commonCount").get.asInstanceOf[Int]))
```
另一种方法：

```
mylist.sortWith(_.get("commonCount").get.asInstanceOf[Int] < _.get("commonCount").get.asInstanceOf[Int])
```


###源码：

```scala

import scala.collection.immutable.{HashMap, List}

/**
  * Created by 185378641@qq.com on 2017/12/7. 
  *
  * @author jiangtao
  *
  *         [
  *         {
  *         "treatmentMoney": 0,
  *         "hospital": "湖南中医学院第二附属医院湖南省中医院",
  *         "commonCount": 2,
  *         "department": "主治医师",
  *         "departmentFunction": "a19ec1789ab711e7a9ff408d5c916e3f",
  *         "docId": "3291ba79901e42bfb756745fb803df64",
  *         "joinedClinic": [
  *         "马冬梅--陈小春"
  *         ],
  *         "docName": "马冬梅--陈小春--张三"
  *         },
  *         {
  *         "treatmentMoney": 0,
  *         "hospital": "湖南中医学院第二附属医院湖南省中医院",
  *         "commonCount": 1,
  *         "department": "主治医师",
  *         "departmentFunction": "a19ec1789ab711e7a9ff408d5c916e3f",
  *         "docId": "1ec9303c79df48d9988bd7bce4370c0e",
  *         "joinedClinic": [
  *         "马冬梅--陈小春--张三",
  *         "小二"
  *         ],
  *         "docName": "麻子"
  *         }
  *         ]
  */

object Main extends App {
  println("hello world")
  //
  //  val days = List(
  //    "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
  //  )

  var one = Map(
    "docName" -> "马冬梅",
    "commonCount" -> 11
  )
  var two = Map(
    "docName" -> "麻子",
    "commonCount" -> 23
  )
  var three = Map(
    "docName" -> "麻子",
    "commonCount" -> 3
  )
  var four = Map(
    "docName" -> "麻子",
    "commonCount" -> 19
  )
  var five = Map(
    "docName" -> "麻子",
    "commonCount" -> 5
  )

  var mylist = List(one, two, three, four, five)

  println(mylist.sortWith((x, y) => x.get("commonCount").get.asInstanceOf[Int] > y.get("commonCount").get.asInstanceOf[Int]))
  println(mylist.sortWith((x, y) => x.get("commonCount").get.asInstanceOf[Int] < y.get("commonCount").get.asInstanceOf[Int]))

  //  println(mylist.sortWith((x,y) => x.get("commonCount"))
  //  mylist.toList.foreach(i => println(i.get("commonCount").getClass))
//
//  var x = Map(
//    "a" -> 1,
//    "b" -> "b"
//  )
//  var y = Map(
//    "a" -> 11,
//    "b" -> "b"
//  )
//  var z = Map(
//    "a" -> 3,
//    "b" -> "b"
//  )

//  println(x.get("a").get.getClass)
//  println(y.get("a").get.getClass)
//  println(z)
//
//  var xyz = List(x, y, z)

  //  println(xyz.sortBy(_.get("a").get))


  /*
    * test
    */

  //  print(mylist.sorted)
  //      print(mylist.flatMap(i => i.get("commonCount")).sortBy(_))
  //      print(mylist.map(i => i.get("commonCount")).sortWith((x,y) => x > y ))
  //    print(mylist.map(i => i.get("commonCount")).sortWith(_.toString > _.toString))
  //    print(mylist.sortBy(i =>(i.get("commonCount"))))
  //    print(mylist.sortBy(_.get("commonCount")))
  //      print(mylist.map(_.foreach(println)))
  //    print(mylist.map(_.get("commonCount")).foreach(println))
  //  print(mylist.sortWith(_.get("commonCount").toString > _.get("commonCount").toString))
  //  println(mylist.sortWith(_.get("commonCount").toString < _.get("commonCount").toString))
  //  println(mylist.sortBy(_.get("commonCount").toString))
  //    println(mylist.sortBy(_.values))
  //  println(mylist.sorted(Ordering.Int.reverse))
  //  println(mylist.sortBy(_.get("commonCount")))
  //  println(mylist.groupBy(_.get("commonCount")))
  //  println(mylist.sortWith(_.foreach(println(_._2))))
  //  println(mylist.map(_.mapValues()))
  //  println(mylist.sortBy(i => i.get("commonCount").toString ))
  //  println(mylist.sortBy(i => (x = i.get("commonCount"),y=i.get("commonCount") )=>
  //  println(mylist.sortWith((x,y)=>x.get("commonCount").toString > y.get("commonCount").toString))
  //    println(mylist.sortWith((x, y) => x.get("commonCount").toString.compareTo(y.get("commonCount").toString)<0))
  //  println(mylist.sortWith((x, y) => x.get("commonCount").toString.compare(y.get("commonCount").toString) < 0))
  //  println(mylist.sortWith(_.get("commonCount") < _.get("commonCount")))

  //  println(mylist.sortBy(_.get("commonCount").foreach(println)))
  //  println(mylist.sortWith(_.get("commonCount").toString >  _.get("commonCount").toString))
  //  println(mylist.sortWith((x, y) => x.get("commonCount").toString < y.get("commonCount").toString))
  //  println(mylist.sorted((x, y) => x.get("commonCount").toString.compareTo(y.get("commonCount").toString)))
  //    println(mylist.sortBy(i => (i.get("commonCount").toString.charAt(0),i.get("commonCount").toString.charAt(1))))
  //    print(mylist.sortBy(_.get("commonCount")))
  //  print(mylist.map(_.get("commonCount") < _.get("commonCount")): _*))
  //  print(mylist.sortBy(i => i.get("commonCount")))
  //  print(mylist.map(_.get("commonCount")).sortBy{_}:_*)
  //  print(mylist.sortWith(_.get("commonCount") > ).toSeq)
  //  var v = mylist.groupBy(_.get("commonCount"))
  //  println(v.keys.toList.foreach(println(_)))


  //    println(v.take(1).foreach(println))


  //  val newMap = mylist.sortBy().foldLeft(new ListMap[String, String]) {
  //    (map, key) => map + (key._1 -> key._2)

  // is ok
  //  var a = Item("马冬梅", 2, "主任")
  //  var b = Item("麻子", 9, "主任")
  //  var c = Item("麻子", 11, "主任")
  //  var d = Item("麻子", 5, "主任")
  //
  //  var mylist = List(a, b, c, d)
  //  println(mylist.sortWith((x,y) => x.commonCount.compare(y.commonCount)>0))
  //  println(mylist.sortBy(i => i.commonCount))


  //  var mymap = List(a,b,c,d).sortBy()
  //  print(mymap)
  //    var mylist =Map(one.get("commonCount")->one,two.get("commonCount")->two,three.get("commonCount")->three).toList.sortBy{_._2}:_*
  //  var mylist = listMap(Map(one->one.get("commonCount"),two.toString()->two.get("commonCount"),three.toString()->three.get("commonCount")).toList.sortBy{_._2}:_*)
  //  var listMap = ListMap(Map("foo"->3, "raise"->1, "the"->2, "bar"->4,"bar1"->4).toList.sortBy{_._2}:_*)


}


case class Item(docName: String, commonCount: Int, departmentName: String)


//
//class Doctor {
//
//  object docId
//
//  object getRealName
//
//  object getDepartmentName
//
//  object getDepartmentFunctionId
//
//  object getHospitalName
//
////  var getTreatmentMoney
//
//  var commonCount:String
//
//  override def toString = commonCount
//
//}
```
