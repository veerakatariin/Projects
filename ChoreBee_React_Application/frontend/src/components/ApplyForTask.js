import { React, useState } from "react";
import Header from "./Main/Header";
import { Link } from "react-router-dom";

const ApplyForTask = (props) => {

    const [salary, setSalary] = useState()
    const [cv, setCv] = useState()

    const loggedUserJSON = window.localStorage.getItem('loggedUser')
    //console.log(loggedUserJSON)
    console.log(props.data)
    console.log(props)
  

      const handleSubmit = () => {
        console.log('submittaa')

      }
      const handleSalaryChange = (event) => {
        setSalary(event.target.value)
      }
      const handleCVChange = (event) => {
        setCv(event.target.value)
      }


    return(
        <div className="background">
        <Header />
        <form input type="submit" className="form">

        <h1 className="h1">Submit a proposal </h1>

          <h3>Job details</h3>
          <p>headline</p>
          <p>description</p>
          <p>view task posting</p>

            <div className="inputFields">
                    <label for="salary">What is the rate you would complete this task for? </label>
                    <input type="text" placeholder="palkka numero " name="salary" onChange={handleSalaryChange} required/>
                    
                    <label for="cv">Cover Letter (optional) </label>
                    <input type="text" placeholder="cv" name="cv" onChange={handleCVChange} required/>

                    <label for="files">Attach files</label>
                    <input type="text"  name="files"  required/>

                <br/>
                <Link to="/task"> <button type="button" className="button" onClick={handleSubmit()}>Submit</button></Link>
             </div>
        </form>
    </div>     
    )
    
}


export default ApplyForTask;

 