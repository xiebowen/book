package org.xie.book.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;


/**********
 * 
 * @author 解博文
 *实体类
 */
//@Table(name="book")
public class Book implements Serializable{
	

	private static final long serialVersionUID = 2481884259368412553L;
	
	//书籍id
    //@Id
    //@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	//书籍名称
	private String title;
	//作者
	private String author;
	//页数
	private Integer pages;
	//出版社
	private String publisher;
	//出版时间
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	private Date publishTime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public Integer getPages() {
		return pages;
	}
	public void setPages(Integer pages) {
		this.pages = pages;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public Date getPublishTime() {
		return publishTime;
	}
	public void setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
	}
	
	
	
	
	
}
