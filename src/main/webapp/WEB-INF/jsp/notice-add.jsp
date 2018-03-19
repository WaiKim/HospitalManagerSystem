<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/pintuer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/admin.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.1.min.js"></script>
<script src="${pageContext.request.contextPath }/js/pintuer.js"></script>
</head>
<body>
	<div class="panel admin-panel">
		<div class="panel-head" id="add">
			<strong><span class="icon-pencil-square-o"></span>添加公告</strong>
		</div>
		<div class="body-content">
			<form method="post" class="form-x" id="noticeAddForm" onsubmit="return false;">
				<div class="form-group">
					<div class="label">
						<label>标题：</label>
					</div>
					<div class="field">
						<input type="text" class="input w50" value="" name="title"
							data-validate="required:请输入标题" />
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>类别：</label>
					</div>
					<div class="field">
						<input type="text" class="input w50" value="" name="type"
							data-validate="required:请输入类别" />
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>内容：</label>
					</div>
					<div class="field">
						<textarea rows="5" class="input" name="content" style="height:200px;"></textarea>
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>添加人：</label>
					</div>
					<div class="field">
						<select name="addPerson" class="input" 
							style="width: 95px; line-height: 17px; display: inline-block">
							<option value="">选择</option>
							<option value="管理员">管理员</option>
							<option value="医生">医生</option>
						</select>
						<div class="tips"></div>
					</div>
				</div>
				
		<div class="form-group">
			<div class="label">
				<label></label>
			</div>
			<div class="field">
						<button class="button bg-main icon-check-square-o"
							id="addSubmit" onclick="addForm()">提交</button>
					</div>
		</div>
		</form>
	</div>
	</div>
	<script type="text/javascript">
		function addForm() {
			//ajax的post方式提交表单
			//$("#patientAddForm").serialize()将表单序列号为key-value形式的字符串
			$.post("${pageContext.request.contextPath }/notice/add",
							$("#noticeAddForm").serialize(),
							function(data) {
								if (data.status == 200) {
									alert("添加成功!");
									location.href = "${pageContext.request.contextPath }/notice/list";
								} else if (data.status == 500) {
									alert("添加失败!");
								} 
							});
		}
	</script>
</body>
</html>