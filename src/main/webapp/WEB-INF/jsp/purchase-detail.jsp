<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/pintuer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/admin.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/all.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.1.min.js"></script>
<script src="${pageContext.request.contextPath }/js/pintuer.js"></script>
<script src="${pageContext.request.contextPath }/js/list.js"></script>
<script src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>
</head>
<body>
	<form method="post"
		action="${pageContext.request.contextPath }/purchaseItem/pageByCondition?purchaseNo=${purchase.purchaseNo }"
		id="listform">
		<input type="hidden" id="currentPage" name="currentPage"
			value="${page.currentPage }" />
		<div class="panel admin-panel">
			<div class="panel-head">
				<strong class="icon-align-left">采药单信息</strong>
			</div>
			<div class="padding border-bottom">
				<table class="table table-hover text-center table-bordered">
					<tr>
						<th width="150" >采药单编号</th>
						<th width="200" >供药商名称</th>
						<th width="100" >总数量</th>
						<th width="100" >总价格</th>					
						<th width="150" >创建时间</th>
						<th width="80" >操作员</th>
						<th width="150" >备注</th>
					</tr>
					<tr>
						<td>
							${purchase.purchaseNo }
						</td>
						<td>
							${purchase.provider.providerName }
						</td>
						<td>
							${purchase.totalQuantity }
						</td>
						<td>
							${purchase.totalPrice }
						</td>
						<td>
							<fmt:formatDate type="date" value="${purchase.createTime }"/>
						</td>
						<td>
							${purchase.operator }
						</td>
						<td>
							${purchase.remarks }
						</td>
					</tr>
				</table>	
				<br/>
				<ul class="search" style="padding-left: 10px;">
					<li>
						<a class="button border-main icon-plus-square-o" href="${pageContext.request.contextPath }/purchaseItem/skipToAdd?purchaseNo=${purchase.purchaseNo }">
							添加药品项目
						</a>
					</li>
				</ul>		

			</div>
			
			<div class="panel-head">
				<strong class="icon-reorder">药品清单</strong>
			</div>
			
			<table class="table table-hover text-center table-bordered">
				<tr>
					<th width="125" style="text-align: left; padding-left: 20px;">序号</th>
					<th width="150" >医药名称</th>
					<th width="170" >生产日期</th>
					<th width="170" >有效期至</th>
					<th width="100" >产品批号</th>	
					<th width="100" >进药单价</th>				
					<th width="100" >数量</th>
					<th width="80" >进药总价</th>
					<th width="150" >库存状态</th>
					<th width="200" >目标仓库</th>
					<th width="620" >操作</th>
				</tr>
				<c:forEach items="${purchaseItemList}" var="purchaseItem"  varStatus="status">
					<tr>
						<td style="text-align: left; padding-left: 20px;">
							<input type="checkbox" name="id[]" value="${purchaseItem.id}" />
								<span>
									${(page.currentPage-1)*3+status.count}
								</span>
						</td>

						<td>${purchaseItem.drugName }</td>
						<td>${purchaseItem.produceTime }</td>
						<td>${purchaseItem.validTime }</td>
						<td>${purchaseItem.batchNo }</td>
						<td>${purchaseItem.purchasePrice }</td>
						<td>${purchaseItem.quantity }</td>
						<td>${purchaseItem.purchaseTotalPrice }</td>
						<td>${purchaseItem.status }</td>
						<td>${purchaseItem.warehouseNo }</td>
						<td><div class="button-group">
								<a class="button border-main"
									href="${pageContext.request.contextPath }/purchaseItem/updateById?id=${purchaseItem.id }&&purchaseNo=${purchase.purchaseNo}">
									<span class="icon-edit"></span> 修改
								</a> 
								<a class="button border-red"
									href="javascript:putInStock(${purchaseItem.id })">
									<span class="icon-database"></span> 入库
								</a>								
								<a class="button border-red"
									href="javascript:judgeDelete(${purchaseItem.id })">
									<span class="icon-trash-o"></span> 删除
								</a>
							</div>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td style="text-align: left; padding: 19px 0; padding-left: 20px;border-style:none;"><input
						type="checkbox" id="checkall" /> 全选</td>
					<td colspan="5" style="text-align: left; padding-left: 20px;border-style:none;"><a
						href="javascript:deleteBatch()"
						class="button border-red icon-trash-o" style="padding: 5px 15px;" >
							删除</a></td>

				</tr>
				<tr>
					<td colspan="9" style="border-style:none;">
						<div class='page fix'>
							共 <b>${page.totalNumber}</b> 条
							<c:if test="${page.currentPage != 1}">
								<a href="javascript:changeCurrentPage('1')" class='first'>首页</a>
								<a href="javascript:changeCurrentPage('${page.currentPage-1}')"
									class='pre'>上一页</a>
							</c:if>
							当前第<span>${page.currentPage}/${page.totalPage}</span>页
							<c:if test="${page.currentPage != page.totalPage}">
								<a href="javascript:changeCurrentPage('${page.currentPage+1}')"
									class='next'>下一页</a>
								<a href="javascript:changeCurrentPage('${page.totalPage}')"
									class='last'>末页</a>
							</c:if>
							跳至&nbsp;<input id="currentPageText" type='text'
								value='${page.currentPage}' class='allInput w28' />&nbsp;页&nbsp;
							<a
								href="javascript:changeCurrentPage($('#currentPageText').val())"
								class='go'>GO</a>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
	<script type="text/javascript">
	 	function getSelectionsIds(){
	 		var obj=document.getElementsByName('id[]'); //选择所有name="'id[]'"的对象，返回数组 
	 		//取到对象数组后，我们来循环检测它是不是被选中 
	 		var s=''; 
	 		for(var i=0; i<obj.length; i++){ 
	 		if(obj[i].checked){
	 			s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	 			} 	
	 		} 
	 		//那么现在来检测s的值就知道选中的复选框的值了 
	 		//alert(s==''?'你还没有选择任何内容！':s); 
	 		return s;
	    }
	 	
		function judgeDelete(id) {
			
			if (confirm("确定要删除id为" + id + "的记录吗？")) {
				var params = {"id":id};
				$.post("${pageContext.request.contextPath }/purchaseItem/deleteOne",params ,function(data){
        			if(data.status == 200){
        				alert('删除成功!');
        				location.href = "${pageContext.request.contextPath }/purchase/findByPurchaseNo?purchaseNo=${purchase.purchaseNo }";
        			}
        			if(data.status == 500){
        				alert(data.msg);
        				location.href = "${pageContext.request.contextPath }/purchase/findByPurchaseNo?purchaseNo=${purchase.purchaseNo }";
        			}
        		});
				//window.location.href = "${pageContext.request.contextPath }/patient/deleteOne?id="+ id;
			}
		}
		
		function putInStock(id) {
			
			if (confirm("确定要入库id为" + id + "的记录吗？")) {
				var params = {"id":id};
				$.post("${pageContext.request.contextPath }/stock/add",params ,function(data){
        			if(data.status == 200){
        				alert('入库成功!');
        				location.href = "${pageContext.request.contextPath }/purchase/findByPurchaseNo?purchaseNo=${purchase.purchaseNo }";
        			}
        			if(data.status == 500){
        				alert(data.msg);
        				location.href = "${pageContext.request.contextPath }/purchase/findByPurchaseNo?purchaseNo=${purchase.purchaseNo }";
        			}
        		});
				//window.location.href = "${pageContext.request.contextPath }/patient/deleteOne?id="+ id;
			}
		}

		//搜索
		function changesearch() {
			$('#currentPage').val('1');
			$('#listform').submit();
		}

		//全选
		$("#checkall").click(function() {
			$("input[name='id[]']").each(function() {
				if (this.checked) {
					this.checked = false;
				} else {
					this.checked = true;
				}
			});
		});

		//批量删除
		function deleteBatch() {
			var Checkbox = false;
			$("input[name='id[]']").each(function() {
				if (this.checked == true) {
					Checkbox = true;
				}
			});
			if (Checkbox) {
				var t = confirm("您确认要删除选中的内容吗？");
				if (t == false){
					return false;
				}
				var ids = getSelectionsIds();
				var params = {"ids":ids};
				$.post("${pageContext.request.contextPath }/purchaseItem/deleteBatch",params ,function(data){
        			if(data.status == 200){
        				alert('删除采药单成功!');
        				location.href = "${pageContext.request.contextPath }/purchase/findByPurchaseNo?purchaseNo=${purchase.purchaseNo }";
        			}
        			if(data.status == 500){
        				alert(data.msg);
        				location.href = "${pageContext.request.contextPath }/purchase/findByPurchaseNo?purchaseNo=${purchase.purchaseNo }";
        			}
        		});
				//$('#listform').attr("action","${pageContext.request.contextPath }/patient/deleteBatch");
				//$("#listform").submit();
			} else {
				alert("请选择您要删除的内容!");
				return false;
			}
		}
	</script>
</body>
</html>