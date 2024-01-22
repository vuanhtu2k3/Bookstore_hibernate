package com.hibernate.utils;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtils {

	private static final SessionFactory sessionFactory ;
	
	
	    static {
	    	try {
	    		Configuration configuration = new Configuration().configure("hibernate.cfg.xml");
	    		System.out.println("==============");
	    		sessionFactory = configuration.buildSessionFactory();
	    	} catch(HibernateException ex) {
	    		  System.err.println("Initial SessionFactory creation failed." + ex);
	              throw new ExceptionInInitializerError(ex);
	    	}
	    }
	    
	    public static SessionFactory getSessionFactory() {
	    	return sessionFactory;
	    }
	
}
