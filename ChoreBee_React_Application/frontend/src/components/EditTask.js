import Header from "./Main/Header";
import { useEffect, React, useState } from "react";
import profile from "../services/GetData.js"
import { Link } from "react-router-dom";

const EditTask = (props) => {

  const eTask = window.localStorage.getItem('edittask')
  const taskEdit = JSON.parse(eTask)

    const [headline, setHeadline] = useState()
    const [description, setDescription] = useState()
    const [location, setLocation] = useState()
    const [salary, setSalary] = useState()
    const [duration, setDuration] = useState()
    const [active, setActive] = useState()
    const [user, setUser] = useState()
  
    const taskObject = {
        headline: headline,
        description: description, 
        location: location,
        salary: salary,
        duration: duration,
        active: active,
        user: user
      }

      const handleHeadlineChange = (event) => {
        setHeadline(event.target.value)
      }
      const handleDescriptionChange = (event) => {
        setDescription(event.target.value)
      }
      const handleLocationChange = (event) => {
        setLocation(event.target.value)
      }
      const handleSalaryChange = (event) => {
        setSalary(event.target.value)
      }
      const handleDurationChange = (event) => {
        setDuration(event.target.value)
      }

      const update = () => {
        profile.updateTask(taskEdit._id, taskObject)
      }


    return(
      
        <div>
          <Header />
          <form input type="submit">
                <ul>
                    <li>
                        <label for="headline">Headline:</label>
                        <input type="text" id="head" name="head" defaultValue={taskEdit.headline} onChange={handleHeadlineChange}/>
                    </li>
                    <li>
                        <label for="description">Description:</label>
                        <input type="text" id="des" name="description" defaultValue={taskEdit.description} onChange={handleDescriptionChange}/>
                    </li>
                    <li>
                        <label for="loc">Location:</label>
                        <input type="text" id="loc" name="loc" defaultValue={taskEdit.location} onChange={handleLocationChange}/>
                    </li>
                    <li>
                        <label for="sal">Salary:</label>
                        <input type="text" id="sal" name="sal" defaultValue={taskEdit.salary} onChange={handleSalaryChange} />
                    </li>
                    <li>
                        <label for="dur">Duration:</label>
                        <input type="text" id="age" name="dur" defaultValue={taskEdit.duration} onChange={handleDurationChange} />
                    </li>
                </ul>
                <Link to="/task"><button type="button" className="button" onClick={() => update()} >Update</button></Link>
            </form>
        </div>
        
    )}
    

export default EditTask;