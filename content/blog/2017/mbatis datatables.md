title=mybatis(pagehelper) dataTables实现分页功能
date= 21/11/2017 
type=post
tags=mybatis datatables 分页
status=published
~~~~~~
> 网上有一些资料，感觉都不完整，这里整理一下，方便使用

心急的直接看代码：[GitHub - chenjiangtao/mybatis-pagehelper-datatables](https://github.com/chenjiangtao/mybatis-pagehelper-datatables)

1. 包引入

PageHelper引入
```xml
	<!-- mybatis 分页插件 -->
	<dependency>
	    <groupId>com.github.pagehelper</groupId>
	    <artifactId>pagehelper</artifactId>
	    <version>4.1.6</version>
	</dependency>
```

DataTables引入(包含css 和js两个部分)
```html
	<!— DataTables CSS -->
	    <link href="/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
	    <!-- DataTables Responsive CSS -->
	    <link href="/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
	<!-- DataTables JavaScript -->
	    <script src="/vendor/datatables/js/jquery.dataTables.min.js"></script>
	    <script src="/vendor/datatables-plugins/
dataTables.bootstrap.min.js"></script>
	    <script src="/vendor/datatables-responsive/dataTables.responsive.js"></script>
```
参考：
[https://github.com/pagehelper/Mybatis-PageHelper](https://github.com/pagehelper/Mybatis-PageHelper)
[https://datatables.net/examples/server\_side/index.html](https://datatables.net/examples/server_side/index.html)
2. 使用说明
Server side部分(java spring)
建一个类`DataTablePageUtil.java`

``` java
package org.cjt;

public class DataTablePageUtil<T> {

    /*------------------DT自动请求的参数(Sent parameters) begin--------------------*/
    /*
     * 绘制计数器。这个是用来确保Ajax从服务器返回的是对应的（Ajax是异步的，因此返回的顺序是不确定的）。 要求在服务器接收到此参数后再返回
	 */
    private int draw; // 第几次请求
    /*
     * 第一条数据的起始位置，比如0代表第一条数据
     */
    private int start = 0;// 起止位置
    /*
     * 告诉服务器每页显示的条数，这个数字会等于返回的 data集合的记录数，可能会大于因为服务器可能没有那么多数据。
     * 这个也可能是-1，代表需要返回全部数据(尽管这个和服务器处理的理念有点违背)
     */
    private int length = 100; // 数据长度

    /*
     * 全局的搜索条件，条件会应用到每一列（ searchable需要设置为 true ）
     */
    private String search;

    /*
     * 如果为 true代表全局搜索的值是作为正则表达式处理，为 false则不是。
     * 注意：通常在服务器模式下对于大数据不执行这样的正则表达式，但这都是自己决定的
     */
    private boolean is_search;

    /*
     * 告诉后台那些列是需要排序的。 i是一个数组索引，对应的是 columns配置的数组，从0开始
     */
    private int[] order;

    /*
     * 告诉后台列排序的方式， desc 降序 asc升序
     */
    private String order_dir;

    /*
     * columns 绑定的数据源，由 columns.dataOption 定义。
     */
    private String columns_data;

    /*
     * columns 的名字，由 columns.nameOption 定义。
     */
    private String columns_name;

    /*
     * 标记列是否能被搜索,为true代表可以，否则不可以，这个是由 columns.searchableOption 控制
     */
    private String columns_searchable;

    /*
     * 标记列是否能排序,为 true代表可以，否则不可以，这个是由 columns.orderableOption 控制
     */
    private boolean is_orderable;

    /*
     * 标记具体列的搜索条件
     */
    private String columns_search_value;

    /*
     * 特定列的搜索条件是否视为正则表达式， 如果为 true代表搜索的值是作为正则表达式处理，为 false则不是。
     * 注意：通常在服务器模式下对于大数据不执行这样的正则表达式，但这都是自己决定的
     */
    private boolean is_search_regex;

	/*------------------DT自动请求的参数(Sent parameters) end--------------------*/

	/*------------------服务器需要返回的数据(Returned data) begin--------------------*/

	/*
     * 必要。上面提到了，Datatables发送的draw是多少那么服务器就返回多少。
	 * 这里注意，作者出于安全的考虑，强烈要求把这个转换为整形，即数字后再返回，而不是纯粹的接受然后返回，这是 为了防止跨站脚本（XSS）攻击。
	 */
    // private int draw;

    /*
     * 必要。即没有过滤的记录数（数据库里总共记录数）
     */
    private int recordsTotal;

    /*
     * 必要。过滤后的记录数（如果有接收到前台的过滤条件，则返回的是过滤后的记录数）
     */
    private int recordsFiltered;

    /*
     * 必要。表中中需要显示的数据。这是一个对象数组，也可以只是数组， 区别在于 纯数组前台就不需要用 columns绑定数据，会自动按照顺序去显示
     * ，而对象数组则需要使用 columns绑定数据才能正常显示。 注意这个 data的名称可以由 ajaxOption 的
     * ajax.dataSrcOption 控制
     */
    private List<T> data;

    /*
     * 可选。你可以定义一个错误来描述服务器出了问题后的友好提示
     */
    private String error;

	/*-------------可选参数-----------------*/

    /*
     * 自动绑定到 tr节点上
     */
    private String dt_rowId;

    /*
     * 自动把这个类名添加到 tr
     */
    private String dt_rowClass;

    /*
     * 使用 jQuery.data() 方法把数据绑定到row中，方便之后用来检索（比如加入一个点击事件）
     */
    private Object dt_rowData;

    /*
     * 自动绑定数据到 tr上，使用 jQuery.attr() 方法，对象的键用作属性，值用作属性的值。 注意这个 需要 Datatables
     * 1.10.5+的版本才支持
     */
    private Object dt_rowAttr;

	/*-------------可选参数-----------------*/
    /*------------------服务器需要返回的数据(Returned data) end--------------------*/


    /*
     * 当前页码
     */
    private int page_num = 1;

    /*
     * 每页数据
     */
    private int page_size = 100;


    public DataTablePageUtil() {

    }

    public DataTablePageUtil(HttpServletRequest request) {
        //开始的数据行数
        String start = request.getParameter("start");
        //每页的数据数
        String length = request.getParameter("length");
        //DT传递的draw:
        String draw = request.getParameter("draw");

        this.setStart(Integer.parseInt(start));
        this.setLength(Integer.parseInt(length));
        this.setDraw(Integer.parseInt(draw));
        //计算页码
        this.page_num = (Integer.parseInt(start) / Integer.parseInt(length)) + 1;

    }
	/**
	* getter setter ....
	*/
}
```
建一个service `Service.java`
	
```
	    /**
	     * 获取所有的数据，前面得有PageHelper兜着
	     * @param userId
	     * @return
	     */
	    public List<SpMsg> getByUserId(Integer userId) {
	        SpMsgExample example = new SpMsgExample();
	        example.createCriteria().andUserIdEqualTo(userId);
	        return mapper.selectByExample(example);
	    }
```
页面部分（jquery-dateFormat jquery,datatables）
独立的js文件 `mydatatable.js`

```javascript
	$(document).ready(function () {
	    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
	    $('#dataTables-smsSendOrder').DataTable({
	        processing: true,
	        serverSide: true,
	        lengthChange: false,//是否允许用户改变表格每页显示的记录数
	        ordering: false,//是否允许用户排序
	        paging: true,//是否分页
	        pagingType: "full_numbers",//除首页、上一页、下一页、末页四个按钮还有页数按钮
	        /* scrollX: true,//允许水平滚动
	         scrollY: "200px",
	         scrollCollapse: true, */
	        searching: false,//是否开始本地搜索
	        stateSave: false,//刷新时是否保存状态
	        autoWidth: true,//自动计算宽度
	        //deferRender : true,//延迟渲染
	        language: {
	            "lengthMenu": "每页 _MENU_ 条记录",
	            "zeroRecords": " ",
	            "info": "当前 _START_ 条到 _END_ 条 共 _TOTAL_ 条",
	            "infoEmpty": "无记录",
	            "infoFiltered": "(从 _MAX_ 条记录过滤)",
	            // "search": "用户",
	            // "processing": "载入中",
	            "paginate": {
	                "first": "首页",
	                "previous": "上一页",
	                "next": "下一页",
	                "last": "尾页"
	            }
	        },
	        ajax: {
	            url: '/admin/module/smsOrderPage',
	            type: 'POST'
	        },
	        columns: [
	            {data: "id"},
	            {data: "mobile"},
	            {data: "content"},
	            {data: "sendChannel", defaultContent: ""},
	            {
	                "data": "createTime",
	                render: function (data) {
	                    return $.format.date(new Date(data), "yyyy-MM-dd HH:mm:ss");
	                }
	            },
	            {
	                data: "sendStatus", render: function (data) {
	                switch (data) {
	                    case '0':
	                        return '初始';
	                    case '1':
	                        return '待发送';
	                    case '2':
	                        return '发送中';
	                    case '3':
	                        return '成功';
	                    case '4':
	                        return '失败';
	                    case '9':
	                        return '未知';
	                    default:
	                        return '初始';
	                }

	            }

	            },
	            {data: "sendReturnMsg", defaultContent: ""}
	        ]
	    });
	});
```
页面引用`mydatatables.jsp`

```html
	<head>
	    <!-- DataTables CSS -->
	    <link href="/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
	    <!-- DataTables Responsive CSS -->
	    <link href="/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
	</head>
	<body>
	<!— /.panel-heading -->
	<div class="panel-body">
	    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-smsSendOrder">
	        <thead>
	        <tr>
	            <th>编号</th>
	            <th>号码</th>
	            <th>内容</th>
	            <th>发送通道</th>
	            <th>创建时间</th>
	            <th>发送状态</th>
	            <th>返回信息</th>
	        </tr>
	        </thead>
	     </table>
	</div>
	</body>
	<!-- /.panel-body -->
	<!-- DataTables JavaScript -->
	<script src="/vendor/datatables/js/jquery.dataTables.min.js"></script>
	<script src="/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
	<script src="/vendor/datatables-responsive/dataTables.responsive.js"></script>
	<script src="/dist/js/smsorder.js"></script>
```
以上，分页功能基本完整了。
参考：
[http://blog.csdn.net/lvbang\_lzt/article/details/54375091](http://blog.csdn.net/lvbang_lzt/article/details/54375091)
[http://www.cnblogs.com/miskis/p/5512138.html](http://www.cnblogs.com/miskis/p/5512138.html)

注意：
如果页面数据显示不准确参考：http://blog.csdn.net/evane1890/article/details/63686578
