create or replace and compile java source named test.java_servlet as
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import java.io.*;
import javax.naming.*;
import oracle.xml.parser.v2.*;

public class JavaServletClass extends HttpServlet {
   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();
    out.println("<title>Example</title>" + "<body bgcolor=FFFFFF>");
    out.println("<h2>Button Clicked</h2>");
    String DATA = request.getParameter("param1");
    if (DATA != null){
      out.println("param1=" + DATA);
    } else {
      out.println("No 'param1' defined!");
    }
    out.close();
  }
  
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();
    out.println("<title>Example</title>" + "<body bgcolor=FFFFFF>");
    out.println("<h2>Button Clicked</h2>");
    String[] DATA = request.getParameterValues("param1");
    if (DATA != null){
      out.println("param1=" + DATA[0]);
    } else {
      out.println("No 'param1' defined!");
    }
    out.close();
    
    /*OutputStream os = response.getOutputStream();
    Hashtable    env = new Hashtable();
    XMLDocument  xt;
    
    try {
      env.put(Context.INITIAL_CONTEXT_FACTORY,"oracle.xdb.spi.XDBContextFactory");
      Context ctx = new InitialContext(env);
      String [] docarr  = request.getParameterValues("doc");
      String doc;
      if (docarr == null || docarr.length == 0)
        doc = "/foo.txt";
      else
        doc = docarr[0];
      xt = (XMLDocument)ctx.lookup(doc);
      response.setContentType("text/xml;charset=UTF-8");
      xt.print(os, "ISO8859");
    } catch (javax.naming.NamingException e) {
      response.sendError(404, "Java exception: " + e);
    } finally {
      os.close();
    }*/
  }
}
