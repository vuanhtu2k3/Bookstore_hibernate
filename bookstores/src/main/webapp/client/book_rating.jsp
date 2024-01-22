<c:forTokens items="${book.ratingStars}" delims="," var="star">
	<c:if test="${star eq 'on'}">
    <img src="images/rating_on.png" style="width: 40px; height: 40px;" />
</c:if>
<c:if test="${star eq 'off'}">
    <img src="images/rating_off.png" style="width: 40px; height:40px;" />
</c:if>
<c:if test="${star eq 'half'}">
    <img src="images/rating_half.png" style="width: 40px; height: 40px;" />
</c:if>
	
	
	
	
</c:forTokens>