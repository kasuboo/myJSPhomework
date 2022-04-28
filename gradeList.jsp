<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
    <%
      //判断图书编号
      File files=new File("D://books.txt");
      FileReader frs=new FileReader(files); //字符输入流
      BufferedReader brs=new BufferedReader(frs); 
      String lineNum="";
      int number=0; //图书编号
      while((lineNum=brs.readLine())!=null)
      {
  	    number++;
      }      
      brs.close();
      String nLine=request.getParameter("nl");
      String nLine2=request.getParameter("nl2");
      String BookName=request.getParameter("bookname");
      String Writer=request.getParameter("writer");
      String Price=request.getParameter("price");
      String Outname=request.getParameter("outname");
      String Time=request.getParameter("outtime");
      String num=""+number;
      //获取单选框的值
      String Type=request.getParameter("check");
      String newStr=num+' '+BookName+' '+Writer+' '+Type+' '+Price+' '+Outname+' '+Time+' '; //新增行的信息  
            
      int cNELine=0,cNELine2=0;     
      try{
		  cNELine=Integer.parseInt(nLine); //当前需要修改的行号
	  }catch (Exception e){
		  e.printStackTrace();
	  }  
      try{
		  cNELine2=Integer.parseInt(nLine2); //当前需要删除的行号
	  }catch (Exception e){
		  e.printStackTrace();
	  }
      if(nLine!=null&&cNELine!=0) //修改
      {    	   
    	  File file_03=new File("D://books.txt");
          FileReader fr_03=new FileReader(file_03); 
          BufferedReader br_03=new BufferedReader(fr_03);   
          String temp=br_03.readLine();
          String allStr="";
          int in=0;
          while(temp!=null) //更新文件信息
          {    	  
        	  if(in==cNELine)
        	  {
        		num=cNELine+""; //更新图书编号
        		newStr=num+' '+BookName+' '+Writer+' '+Type+' '+Price+' '+Outname+' '+Time+' ';
        		allStr=allStr+newStr+"\n";      		  
        	  }       		  
        	  else
        		  allStr=allStr+temp+"\n";   	  
        	  temp=br_03.readLine();
        	  in++;
          }
          br_03.close();         
          File file_04=new File("D://books.txt");
          FileWriter writef_04=new FileWriter(file_04);
          if(BookName!=null&&Writer!=null&&Type!=null&&Price!=null&&Outname!=null&&Time!=null)
          {
        	  writef_04.write(allStr);
          } 
          writef_04.close();
      }    	      
      if(cNELine2!=0) //删除
      { 
    	  File file_05=new File("D://books.txt");
          FileReader fr_05=new FileReader(file_05); 
          BufferedReader br_05=new BufferedReader(fr_05);   
          String temp2=br_05.readLine();
          String allStr2="";
          int in2=0;
          while(temp2!=null) //更新文件信息
          {    	        		  
        	  if(cNELine2!=in2)
        	  {
        		  allStr2=allStr2+temp2+"\n";  
        	  }       		   	  
        	  temp2=br_05.readLine();
        	  in2++;
          }
          br_05.close();         
          File file_06=new File("D://books.txt");
          FileWriter writef_06=new FileWriter(file_06);
          writef_06.write(allStr2);
          writef_06.close();
      }      
      //打开txt文件
      File file_02=new File("D://books.txt");
      FileWriter writef=new FileWriter(file_02,true);
      if(BookName!=null&&Writer!=null&&Type!=null&&Price!=null&&Outname!=null&&Time!=null&&cNELine==0&&cNELine2==0) //新增
      {
    	  writef.write(newStr+"\n");
      }    
      writef.close();
      //实时检查更新图书编号
      FileReader fr_07=new FileReader("D://books.txt"); 
      BufferedReader br_07=new BufferedReader(fr_07);
      String temp3=br_07.readLine();
      String allStr3="";
      int ch3,index3=0,n=1;
      String finalStr="图书编号 图书名称 作者信息 类型 价格 出版社 出版时间"+"\n";
      char ts;
      while((ch3=br_07.read())!=-1) //更新文件信息
      {
    	  if((char)ch3!=' ')
    	  {
    		  if(index3==0)
    		  {
    			  finalStr=finalStr+""+n;
    			  n++; //图书编号++
    		  }
    		  else
    		  {
    			  ts=(char)ch3;
    			  finalStr=finalStr+String.valueOf(ts);
    			  if(index3==7)
    			  {
    				  index3=0;
    				  //finalStr=finalStr+"\n";
    			  }   				  
    		  }
    	  }
    	  else
    	  {
    		  index3++;
    		  finalStr=finalStr+" ";
    	  }    		      	  
      }     
      br_07.close();
      File file_08=new File("D://books.txt");
      FileWriter writef_08=new FileWriter(file_08);
      writef_08.write(finalStr);
      writef_08.close();
      
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <title>My Books List</title>
</head>
<body>
   <!-- 图书表格 -->
   <div id="mytable">
      <table border="1" cellspacing="5" cellpadding="1" id="myTable">
         <tr align="center">
			<td>图书编号</td><td>图书名称</td><td>作者信息</td><td>类型</td>
			<td>价格</td><td>出版社</td><td>出版时间</td><td>操作</td>
		</tr>
		<!-- 读取txt文档信息 -->
        <%
           //String filePath=application.getRealPath("/books.txt");
           File file=new File("D://books.txt");
           FileReader fr=new FileReader(file); //字符输入流
           BufferedReader br=new BufferedReader(fr); //字符缓冲流,可以逐行读取            
           String Line_1=br.readLine(); //读取第一行
           int ch; //逐个读取文件中的字符
           String s="";
           int index=1;
           while((ch=br.read())!=-1)
           {       	   
        	   if(index==1)
        		   out.println("<tr align='center'>");        	   
        	   if((char)ch!=' ')
        	   {
        		   s=s+(char)ch;
        	   }
        	   else
        	   {
        		   out.println("<td>");
        		   out.println(s);
        		   out.println("</td>");
        		   s="";
        		   index++;
        	   }
        	   if(index==8)
        	   {
        		   out.println("<td>"+"<a href='javascript:void(0);' onclick='formReset()'>修改</a>"+"&nbsp"+"<a href=''>删除</a>");
        		   out.println("<input type='button' onclick='editRow(this)' value='修改'/>");
        		   out.println("<input type='button' onclick='remove(this)' value='删除'/>");
        		   out.println("</tr>");
        		   index=1;
        	   }
           }          
           br.close();
        %>
      </table>  
      <input type="button" value="新增图书" onclick="formReset()"/>&nbsp<input type="button" value="操作信息" /><p></p>
   </div>

   <!-- 图书信息列表 -->
   <div id="form1">
     <form id="myform" action="gradeList.jsp" method="post">
      <fieldset>
         <legend>图书信息</legend>
         名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：<input type="text" name="bookname" id="bookname"><br>
         作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;者：<input type="text" name="writer" id="writer"><br>
         类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：<input type="radio" name="check" value="软件工程">软件工程&nbsp;
         <input type="radio" name="check" value="程序设计">程序设计&nbsp;
         <input type="radio" name="check" value="数据结构">数据结构<br>
         价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格：<input type="text" name="price" id="price"><br>
         出&nbsp;版&nbsp;社：<select name="outname" id="outname">
           <option value="清华大学出版社" selected="">清华大学出版社</option>
						<option value="北京大学出版社">北京大学出版社</option>
						<option value="机械工业出版社">机械工业出版社</option>
         </select><br>        
         出版时间：<input type="text" name="outtime" id="outtime"><br>
         <input type="submit" value="取消">&nbsp;&nbsp;<input type="submit" value="确定">
         <input type="text" style="display:none" name="nl" id="nl"/>
         <input type="text" style="display:none" name="nl2" id="nl2"/>
      </fieldset>
     </form>  
   </div>  
</body>
   <script type="text/javascript">
      <!--删除图书信息-->
      function remove(el)
      {
    	 var tr2=el.parentNode.parentNode;
 		 var cells=tr2.cells; //获取单元格数
    	 var NL=cells[0].innerText; //获取当前行数,便于修改txt文档
    	 document.getElementById('nl2').value=NL;
      }
      <!--功能:按下按钮后清空表单-->
	  function formReset()
	  {
		 document.getElementById('myform').reset();
	  }
	  <!--修改图书信息-->
	  function editRow(el){
		 var tr=el.parentNode.parentNode;
		 var cells=tr.cells; //获取单元格数
		 var NL=cells[0].innerText; //获取当前行数,便于修改txt文档
		 var bn=cells[1].innerText;
		 var wt=cells[2].innerText;
		 var type=cells[3].innerText;
		 var p=cells[4].innerText;
		 var out=cells[5].innerText;
		 var time=cells[6].innerText;
		 var checkr=document.getElementsByName('check');
			for(var i=0;i<checkr.length;i++)
			{
				if(checkr[i].value==type)
				{
					checkr[i].checked=true;
					break;
				}
			}
		 document.getElementById('bookname').value=bn;
	     document.getElementById('writer').value=wt;
		 document.getElementById('price').value=p;
		 document.getElementById('outname').value=out;
		 document.getElementById('outtime').value=time;	
		 document.getElementById('nl').value=NL;
	  }	  
   </script> 
</html>
