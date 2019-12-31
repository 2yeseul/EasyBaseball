package com.example.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.model.searchPlayerInfo;
import com.example.model.searchStats;
import user.UserDAO;
import user.playerInfo;
import user.records;

/**
 * Servlet implementation class stats
 */
@WebServlet("/stats.do")
public class stats extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public stats() {
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
		//request.setCharacterEncoding("UTF-8");
		String batterName = request.getParameter("batterName");
		String numberOfHits = request.getParameter("numberOfHits");
		String numberOfHomeruns = request.getParameter("numberOfHomeruns");
		
		UserDAO batter = new UserDAO();
		records batterRecords = new records();
		records batterHomerunsRecords = new records();
		batterRecords = batter.getBatterRecord(batterRecords, batterName, numberOfHits);
		batterHomerunsRecords = batter.getBatterHomeruns(batterHomerunsRecords, batterName, numberOfHomeruns);
		
		request.setAttribute("numberOfHits", numberOfHits);
		request.setAttribute("batterRecords",batterRecords);
		request.setAttribute("numberOfHomeruns", numberOfHomeruns);
		request.setAttribute("batterHomerunsRecords", batterHomerunsRecords);
		//request.setCharacterEncoding("UTF-8");
		RequestDispatcher view = request.getRequestDispatcher("resultSearchStats.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
