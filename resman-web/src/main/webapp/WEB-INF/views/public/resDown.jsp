<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript" src="${ctx}/asset/js/jquery-2.1.1.min.js"></script>
<script>
    $(document).ready(function(){
        alert('ss');
        var url = '/res/document/download?uuid=${uuid}';
        window.open( url );
    });


</script>