import Header from "./Main/Header";
import { useEffect, React, useState } from "react";
import profile from "../services/GetData.js"
import styles from './Style/ProfilePage.css'
import { Link } from "react-router-dom";
import EditProfile from "./EditProfile";


const ProfilePage = () => {

    const [user, setUser] = useState({})

    const loggedUserJSON = window.localStorage.getItem('loggedUser')
    const userlog = JSON.parse(loggedUserJSON)

    useEffect(() => {
        profile
        .getUser(userlog.id)
        .then(res => {
          setUser(Object(res));
        })
      }, [])

      
    return(
      
    <div Name="container">
      <div className="main-body">
      <Header />

        <div className="row gutters-sm">
            <div className="col-md-4 mb-3">
                <div className ="card">
                    <div className="card-body">
                        <div className="d-flex flex-column align-items-center text-center">
                            <img src="https://iili.io/HamP0Ou.png" alt="Admin" className="rounded-circle" width="150"/>
                            <div className="mt-3">
                            <h4>{user.name}</h4>
  
                            <Link to="/task"><button className="btn btn-primary">My tasks</button></Link>
                            <Link to="/editprofile"><button className="btn btn-outline-primary" onClick={() => EditProfile(user)} >edit profile</button></Link>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div className="card mt-3">
                        <ul class="list-group list-group-flush">
                          <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                            <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="feather feather-globe mr-2 icon-inline"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>Website</h6>
                            <span class="text-secondary">https://bootdey.com</span>
                          </li>
                        </ul>
                      </div>   
                    </div>
            
                    <div className="col-md-8">
                      <div className="card mb-3">
                        <div className="card-body">

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Full Name</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {user.name}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Description</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {user.info}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Email</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {user.email}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Phone</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {user.number}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Age</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {user.age} years old
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Address</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {user.address}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Password</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {user.password}
                            </div>
                          </div>
                          <hr/>

                          
                      </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
}

export default ProfilePage;
