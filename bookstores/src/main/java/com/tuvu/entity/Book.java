package com.tuvu.entity;

import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.tuvu.entity.Review;
import com.tuvu.entity.Book;


@Entity
@Table(name = "book", catalog = "bookstores")
@NamedQueries({
	@NamedQuery(name = "Book.listNew", query = "SELECT b FROM Book b "),
	@NamedQuery(name = "Book.findByName", query = "SELECT b FROM Book b WHERE b.name = :name"),
	@NamedQuery(name = "Book.findByCategory", query = "SELECT b FROM Book b JOIN "
			+ "Category c ON b.category.categoryId = c.categoryId AND c.categoryId = :catId"),
    @NamedQuery(name = "Book.findAll", query = "SELECT b FROM Book b"),
    @NamedQuery(name = "Book.countAll", query = "SELECT COUNT(*) FROM Book b"),
    @NamedQuery(name = "Book.countByCategory", query = "SELECT COUNT(b) FROM Book b "
			+ "WHERE b.category.categoryId = :catId")
})
public class Book {

    private Integer bookId;
    private String name;
    private String author;
	private String description;
    private Category category;  // Sử dụng đối tượng Category thay vì int
    private float price;
    private String image;
    private Set<Review> reviews = new HashSet<Review>(0);
    
    public Book(Integer bookId, String name, String author, Category category, float price, String image) {
        super();
        this.bookId = bookId;
        this.name = name;
        this.author = author;
        this.category = category;
        this.price = price;
        this.image = image;
    }
    
    


	public Book(Integer bookId, String name, String author, Category category, float price, String image,
			Set<Review> reviews) {
		super();
		this.bookId = bookId;
		this.name = name;
		this.author = author;
		this.category = category;
		this.price = price;
		this.image = image;
		this.reviews = reviews;
	}


	public Book(Integer bookId) {
		super();
		this.bookId = bookId;
	}
    public Book() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    public String toString() {
        return "Book [book_id=" + bookId + ", name=" + name + ", author=" + author + ", category=" + category
                + ", price=" + price + ", image=" + image + "]";
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "book_id")
    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "author")
    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    @ManyToOne
    @JoinColumn(name = "category_id")
    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Column(name = "price")
    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    @Column(name = "description", nullable = false, length = 16777215)  
    public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}


	@OneToMany(fetch = FetchType.EAGER, mappedBy = "book")
	public Set<Review> getReviews() {
		return reviews;
		
    }
    @Column(name = "image")
	public String getImage() {
		return image;
	}




	public void setImage(String image) {
		this.image = image;
	}




	public void setReviews(Set<Review> reviews) {
		this.reviews = reviews;
	}
    
    @Transient
	public float getAverageRating() {
		float averageRating = 0.0f;
		float sum = 0.0f;
		
		if (reviews.isEmpty()) {
			return 0.0f;
		}
		
		for (Review review : reviews) {
			sum += review.getRating();
		}
		
		averageRating = sum / reviews.size();
		
		return averageRating;
	}
	
	@Transient
	public String getRatingStars() {
		float averageRating = getAverageRating();
		
		return getRatingString(averageRating);
	}
	
	
	@Transient
	public String getRatingString(float averageRating) {
		String result = "";
		
		int numberOfStarsOn = (int) averageRating;
		
		for (int i = 1; i <= numberOfStarsOn; i++) {
			result += "on,";
		}
		
		int next = numberOfStarsOn + 1;
		
		if (averageRating > numberOfStarsOn) {
			result += "half,";
			next++;
		}
		
		for (int j = next; j <= 5; j++) {
			result += "off,";
		}
		
		return result.substring(0, result.length() - 1);
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((bookId == null) ? 0 : bookId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Book other = (Book) obj;
		if (bookId == null) {
			if (other.bookId != null)
				return false;
		} else if (!bookId.equals(other.bookId))
			return false;
		return true;
	}
}
