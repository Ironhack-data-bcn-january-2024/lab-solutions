-- Challenge 1

-- What titles each author has published at what publishers?

USE publications;
SELECT authors.au_id, au_lname, au_fname, pub_name
	FROM titles
    LEFT JOIN titleauthor ON titles.title_id = titleauthor.title_id
	LEFT JOIN authors ON titleauthor.au_id = authors.au_id
	LEFT JOIN publishers ON titles.pub_id = publishers.pub_id;
    

-- Challenge 2 

-- how many titles each author has published at each publisher?

SELECT authors.au_id, au_lname, au_fname, pub_name, COUNT(titles.title_id) AS title_count
	FROM titles
    LEFT JOIN titleauthor ON titles.title_id = titleauthor.title_id
	LEFT JOIN authors ON titleauthor.au_id = authors.au_id
	LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
    GROUP BY pub_name, authors.au_id
    ORDER BY title_count DESC;
    
    
-- Challenge 3

-- Who are the top 3 authors who have sold the highest number of titles?

SELECT authors.au_id, au_lname, au_fname, SUM(qty) AS total
	FROM titles
    LEFT JOIN titleauthor ON titles.title_id = titleauthor.title_id
	LEFT JOIN authors ON titleauthor.au_id = authors.au_id
	LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
    LEFT JOIN sales ON titles.title_id = sales.title_id
    GROUP BY authors.au_id
    ORDER BY total DESC
    LIMIT 3;
    
-- Challenge 4

-- Who are the top 23 authors who have sold the highest number of titles?

 SELECT authors.au_id, au_lname, au_fname, IFNULL(SUM(QTY), 0) AS total 
	FROM titles
	LEFT JOIN titleauthor ON titles.title_id = titleauthor.title_id
	RIGHT JOIN authors ON titleauthor.au_id = authors.au_id
	LEFT JOIN sales ON titles.title_id = sales.title_id
    GROUP BY authors.au_id
    ORDER BY total DESC;   


    






