<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록</title>
<link rel="stylesheet"
	href="http://pinnpublic.dothome.co.kr/cdn/example-min.css">
<style>
	#list th:nth-child(1) { width: 60px; }
	#list th:nth-child(2) { width: 50px; }
	#list th:nth-child(3) { width: 50px; }
	#list th:nth-child(4) { width: auto; }
	#list th:nth-child(5) { width: 100px; }
	#list th:nth-child(6) { width: 60px; }
	
	#list td { text-align: center; }
	#list td:nth-child(4) { text-align: left; }
	
	#add { display: none; }
	#btnAdd { display: none; }
</style>
</head>
<body>
	<!-- ex08.jsp -->
	<h1>
		Address <small>ajax</small>
	</h1>

	<table id="list">
		<thead>
		<tr>
			<th>이름</th>
			<th>나이</th>
			<th>성별</th>
			<th>주소</th>
			<th>등록일</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	
	<div><button class="out" id="toggleAdd" type="button">추가하기</button></div>
	
	
	<form id="addForm">
	<table id="add" class="vertical">
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" id="name" class="short"></td>
		</tr>
		<tr>
			<th>나이</th>
			<td><input type="number" name="age" id="age" min="1" max="100"></td>
		</tr>
		<tr>
			<th>성별</th>
			<td>
				<select name="gender" id="gender">
					<option value="m">남자</option>
					<option value="f">여자</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" name="address" id="address" class="full"></td>
		</tr>
	</table>
	<div id="btnAdd"><button class="add" type="button">등록하기</button></div>
	</form>

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
		
		$('#toggleAdd').click(function() {
			//alert($('#add').css('display'));
			
			 if ($('#add').css('display') == 'none') {
				$('#add').css('display', 'table');
				$(this).removeClass('out');
				$(this).addClass('in');
				$(this).text('접기');
				$('#btnAdd').css('display', 'block');
				$('#name').focus();
			} else {
				$('#add').css('display', 'none');
				$(this).removeClass('in');
				$(this).addClass('out');
				$(this).text('펼치기');
				$('#btnAdd').css('display', 'none');
			}  
			
			/* $('#add, #btnAdd').toggle();
			$(this).toggleClass('out');
			$(this).toggleClass('in');  */
		});
		
		
		load();
		
		function load() {
			
			// 기존 <tr> 삭제
			$('#list tbody').html('');
			
			$.ajax({
				type: 'GET',
				url: '/ajax/list.do',
				dataType: 'json',
				success: function(result) {
					// alert(result.length);
					$(result).each((index, item) => {
						// console.log(item);
						
						$('#list tbody').append(`
								
								<tr>
						//	jsp 이기 때문에 ${el}과 충돌, 이스케이프(\)시켜서 js 템플릿 스트링이라고 인식 시켜주기
								<td>\${item.name}</td>
								<td>\${item.age}</td>
								<td>\${item.gender == 'm' ? '남자' : '여자'}</td>
								<td>\${item.address}</td>
								<td>\${item.regdate}</td>
								<td>
									<span class="material-symbols-outlined" onclick="edit(\${item.seq});" style="cursor: pointer;">edit</span>
									<span class="material-symbols-outlined" onclick="del(\${item.seq});" style="cursor: pointer;">delete</span>
								</td>
							</tr>
								
								`);
					});
					
				},
				error: function(a, b, c) {
					console.log(a, b, c);
				}
			});
		};
		
		$('#btnAdd > button').click(function() {
			
			// alert($('#addForm').serialize()); // 직렬화
			
			// ajax > 입력 데이터 전송 > insert
			$.ajax({
				type: 'POST',
				url: '/ajax/add.do',
				data: $('#addForm').serialize(),
				dataType: 'json',
				success: function(result) {
					// alert(result.result);
					
					if (result.result == 1) {
						// 목록 새로 고침
						load();
						
						$('#name').val('');
						$('#age').val('');
						$('#gender').val('m');
						$('#address').val('');
						
						$('#name').focus();
					} else {
						alert('failed');
					}
				},
				error: function(a, b, c) {
					console.log(a, b, c);
				}
			});
		});
		
		function edit(seq) {
			// 클릭 > 수정 버튼(<span>)
			
			let name = $(event.target).parents('tr').children().eq(0).text();
			let age = $(event.target).parents('tr').children().eq(1).text();
			let gender = $(event.target).parents('tr').children().eq(2).text();
			let address = $(event.target).parents('tr').children().eq(3).text();
			
			$(event.target).parents('tr').children().eq(0).html(`<input type="text" style="width: 40px; text-align: center;" value="\${name}" onblur="editName(\${seq});">`);
			$(event.target).parents('tr').children().eq(1).html(`<input type="number" min="1" max="100" style="width: 30px; text-align: center;" value="\${age}" onblur="editAge(\${seq});">`);
			$(event.target).parents('tr').children().eq(2).html(`
					<select onblur="editGender(\${seq});">
						<option value="m" \${gender == '남자' ? 'selected' : ''}>남자</option>
						<option value="f" \${gender == '여자' ? 'selected' : ''}>여자</option>
					</select>
					`);
			$(event.target).parents('tr').children().eq(3).html(`<input type="text" style="width: 310px; text-align: center;" value="\${address}" onblur="editAddress(\${seq});">`);
			
		};
		
		
		function editName(seq) {
			
			// alert(seq);
			
			// 값이 수정 > onchange 발생 > ajax > 서버 전송 > update
			
			// alert($(event.target).val());
			
			const temp = $(event.target);
			
			$.ajax({
				type: 'POST',
				url: '/ajax/edit.do',
				data: {
					column: 'name',
					value: $(event.target).val(),
					seq: seq
				},
				dataType: 'json',
				success: function(result) {
					if (result.result == 1) {
						// alert();
						// 수정 완료 > <td>의 상태 > 원래대로 되돌리기
						temp.parent().text(temp.val());
					} else {
						alert('failed');
					}
				},
				error: function(a, b, c) {
					console.log(a, b, c);
				}
			});
			
		};
		
function editAge(seq) {
			
			// alert(seq);
			
			// 값이 수정 > onchange 발생 > ajax > 서버 전송 > update
			
			// alert($(event.target).val());
			
			const temp = $(event.target);
			
			$.ajax({
				type: 'POST',
				url: '/ajax/edit.do',
				data: {
					column: 'age',
					value: $(event.target).val(),
					seq: seq
				},
				dataType: 'json',
				success: function(result) {
					if (result.result == 1) {
						// alert();
						// 수정 완료 > <td>의 상태 > 원래대로 되돌리기
						temp.parent().text(temp.val());
					} else {
						alert('failed');
					}
				},
				error: function(a, b, c) {
					console.log(a, b, c);
				}
			});
			
		};
		
function editGender(seq) {
			
			// alert(seq);
			
			// 값이 수정 > onchange 발생 > ajax > 서버 전송 > update
			
			// alert($(event.target).val());
			
			const temp = $(event.target);
			
			$.ajax({
				type: 'POST',
				url: '/ajax/edit.do',
				data: {
					column: 'gender',
					value: $(event.target).val(),
					seq: seq
				},
				dataType: 'json',
				success: function(result) {
					if (result.result == 1) {
						// alert();
						// 수정 완료 > <td>의 상태 > 원래대로 되돌리기
						temp.parent().text(temp.val() == 'm' ? '남자' : '여자');
					} else {
						alert('failed');
					}
				},
				error: function(a, b, c) {
					console.log(a, b, c);
				}
			});
			
		};
		
function editAddress(seq) {
			
			// alert(seq);
			
			// 값이 수정 > onchange 발생 > ajax > 서버 전송 > update
			
			// alert($(event.target).val());
			
			const temp = $(event.target);
			
			$.ajax({
				type: 'POST',
				url: '/ajax/edit.do',
				data: {
					column: 'address',
					value: $(event.target).val(),
					seq: seq
				},
				dataType: 'json',
				success: function(result) {
					if (result.result == 1) {
						// alert();
						// 수정 완료 > <td>의 상태 > 원래대로 되돌리기
						temp.parent().text(temp.val());
					} else {
						alert('failed');
					}
				},
				error: function(a, b, c) {
					console.log(a, b, c);
				}
			});
			
		};
		
		function del(seq) {
			
			if (confirm('delete?')) {
				
				$.ajax({
					type: 'POST',
					url: '/ajax/del.do',
					data: 'seq=' + seq,
					dataType: 'json',
					success: function(result) {
						
						if (result.result) {
							load();
						} else {
							alert('failed');
						}
						
					},
					error: function(a, b, c) {
						console.log(a, b, c);
					}
				});
				
			}
			
		};
	
	</script>
</body>
</html>