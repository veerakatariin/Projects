import { useEffect, React, useState } from "react";
import Header from "./Main/Header";
import profile from "../services/GetData.js"
import { Link } from "react-router-dom";

const NewReviewForm = () =>{


    const [review, setReview] = useState()

    const loggedUserJSON = window.localStorage.getItem('loggedUser')
    const userlog = JSON.parse(loggedUserJSON)
   
    const [rating, setRating] = useState(0);
    const [hover, setHover] = useState(0);
    

     const reviewObject = {
      reviewer: 'id_tähä',
      text: review,
      date: 'päivää',
      reviewed_user: 'tähä joku',
      stars: rating
    }

      const handleSubmit = () => {
        
        console.log(review)  
        console.log(rating)
        console.log(loggedUserJSON)
      }
      const handleReviewChange = (event) => {
        setReview(event.target.value)
      }




    return (
        <div>
        <Header />
        <form input type="submit" className="form">

<h1 className="h1">New review</h1>

   <div className="inputFields">
           <label for="headline">Review </label>
           <textarea type="text" placeholder=" Write your review" name="headline" onChange={handleReviewChange} required/>
    
           <label for="location">Stars</label>
          
            <div className="star-rating">
            {[...Array(5)].map((star, index) => {
                index += 1;
                return (
                <star
                    type="star"
                    key={index}
                    className={index <= (hover || rating) ? "on" : "off"}
                    onClick={() => setRating(index)}
                    onMouseEnter={() => setHover(index)}
                    onMouseLeave={() => setHover(rating)}
                >
                    <span className="star">&#9733;</span>
                </star>
                
                );
            })}
    </div>

     
       <Link to="/review"> <button type="button" className="button" onClick={handleSubmit}>Create</button></Link>

    </div>
</form>
      
      </div>
     )

}

export default NewReviewForm;