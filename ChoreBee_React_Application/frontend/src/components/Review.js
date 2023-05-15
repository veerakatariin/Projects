import Header from "./Main/Header";
import { useEffect, React, useState } from "react";
import profile from "../services/GetData.js"

const ReviewPage = () => {

  const [aReview, setAReview] = useState([])
  const [reviewed, setReviewed] = useState([])
  const [revieww, setRevieww] = useState([])

  const loggedUserJSON = window.localStorage.getItem('loggedUser')
  const userlog = JSON.parse(loggedUserJSON)

    useEffect(() => {
        profile
        .getUsersReviews(userlog.id)  //uus funktio joka hakee käyttäjän ja sen reviewsit 
        .then(res => {
          setAReview(res.reviews)
          setReviewed(res.reviewed)
          console.log(res, 'jj')
        })
      }, [])

      const returnStars = (stars) => {
        switch(stars){
          case 5:
            return(<p>&#11088;&#11088;&#11088;&#11088;&#11088;/5</p>)
          case 4: 
          return(<p>&#11088;&#11088;&#11088;&#11088;/5</p>)
          case 3: 
          return(<p>&#11088;&#11088;&#11088;/5</p>)
          case 2: 
          return(<p>&#11088;&#11088;/5</p>)
          case 1: 
          return(<p>&#11088;/5</p>)
          case 0: 
          return(<p>0/5</p>)
        }
      }


    return(
      
    <div Name="container">
      <div className="main-body">
      <Header />

        <div className="row gutters-sm">
            <h2>My Reviews </h2>
           
                
                  {aReview.map(Review => {
                    return(
                    <div className="col-md-8">
                      <div className="card mb-3">
                        <div className="card-body">

                        <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Reviewed user</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {Review.reviewed_user}
                            </div>
                          </div>
                          <hr />


                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Text</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                            {Review.text}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Date</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                            {Review.date}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Stars</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                            {returnStars(Review.stars)}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                             <div className="col-sm-12">
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
)})}

              <h2>I have been reviewed </h2>
                 {reviewed.map(Review => {
                    return(
                    <div className="col-md-8">
                      <div className="card mb-3">
                        <div className="card-body">
                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Reviewer</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                             {Review.reviewer}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Text</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                            {Review.text}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Date</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                            {Review.date}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Stars</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                            {returnStars(Review.stars)}
                            </div>
                          </div>
                          <hr/>


                          <div className="row">
                             <div className="col-sm-12">
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
)})}
                  
            </div>
        </div>
    </div>
    )
}

export default ReviewPage;
