package com.example.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import user.UserDAO;
import user.calendar;

/**
 * Servlet implementation class saveVisit
 */
@WebServlet("/saveVisit.do")
public class saveVisit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public saveVisit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String userID = request.getParameter("userID");
		String userTeam = request.getParameter("userTeam");
		String date = request.getParameter("date");
		
		UserDAO test = new UserDAO();
		String result="";
		result = test.getPlayResult(date, userTeam);
		test.setCalData(userID, date, userTeam, result);
		
		calendar cal = new calendar();
		cal = test.getCalendar(cal, userTeam, userID);
		//result = "{'result' : "+ result +"}";
		//out.print(result);
		//request.setAttribute("results", result);
		//request.setAttribute("date", date);
		//response.getWriter().print(result);
		JSONObject obj = new JSONObject();
		obj.put("data", result);
		/* PrintWriter out= response.getWriter(); */
		out.print(result);
		out.flush();
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
