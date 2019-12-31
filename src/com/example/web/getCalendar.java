package com.example.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import user.UserDAO;
import user.calendar;

/**
 * Servlet implementation class getCalendar
 */
@WebServlet("/getCalendar.do")
public class getCalendar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getCalendar() {
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
		
		UserDAO u = new UserDAO();
		calendar cal = new calendar();
		
		cal = u.getCalendar(cal, userTeam, userID);
		
		// 최종
		JSONObject jsonObject = new JSONObject();
		JSONObject calInfo = new JSONObject();
		String calData ="[";
		for(int i = 0; i < cal.getPlayDate().size(); i++) {
			/*
			 * calInfo.put("title", cal.getPlayResult().get(i).toString());
			 * calInfo.put("start", "2019-"+cal.getPlayDate().get(i).toString());
			 * calInfo.put("backgroundColor", "red");
			 */
			
			  calData+="{ 'title' : '"+ cal.getPlayResult().get(i).toString()
			  +"', 'start' : '2019-"+cal.getPlayDate().get(i).toString() +
			  "', 'backgroundColor' : 'red' },";
			 
			
			/*
			 * out.println("{ 'title' : '" + cal.getPlayResult().get(i).toString() +
			 * "', 'start' : '2019-" + cal.getPlayDate().get(i).toString() +
			 * "', 'backgroundColor' : 'red' },");
			 */
		}
		calData+="]";
		
		response.getWriter().print(calData);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
