import { useEffect, React, useState } from "react";
import Header from "./Main/Header";
import profile from "../services/GetData.js"
import { Link } from "react-router-dom";


const NewTaskForm = () => {

    const [headline, setHeadline] = useState()
    const [description, setDescription] = useState()
    const [location, setLocation] = useState()
    const [salary, setSalary] = useState()
    const [duration, setDuration] = useState()

    const loggedUserJSON = window.localStorage.getItem('loggedUser')
    const userlog = JSON.parse(loggedUserJSON)
    const [userObject, setUserObject] = useState()

    const [clean, setClean] = useState(false)
    const [yard_work, setYard] = useState(false)
    const [assembly, setAssembly] = useState(false)
    const [shopping, setShopping] = useState(false)
    const [pets, setPets] = useState(false)
    const [home_repair, setHomeRepair] = useState(false)
    const [moving, setMoving] = useState(false)
    const [transport, setTransport] = useState(false)
    const [electronics, setElectronics] = useState(false)
    

    useEffect(() => {
      profile
      .getUser(userlog.id)
      .then(res => {
        console.log(res.name)
        setUserObject(res)
      })
    }, [])


    const taskObject = {
        headline: headline,
        description: description,
        location: location,
        salary: salary,
        duration: duration,
        active: true,
        user: userlog.id,
        category: {
          cleaning: clean,
          yard_work: yard_work,
          assembly: assembly,
          shopping: shopping,
          pets: pets,
          home_repair: home_repair,
          moving: moving,
          transport: transport, 
          electronics: electronics
        }
      }

      const handleSubmit = () => {
        profile.addTask(userlog.id, taskObject, userObject)
        console.log(clean)
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



    return(
        <div className="background">
        <Header />
        <form input type="submit" className="form">

         <h1 className="h1">New task</h1>

            <div className="inputFields">
                    <label for="headline">Enter a headline </label>
                    <input type="text" placeholder=" Enter headline" name="headline" onChange={handleHeadlineChange} required/>

                    <br></br>
                    
                    <label for="des">Write a description about the task </label>
                    <input type="text" placeholder=" description" name="des" onChange={handleDescriptionChange} required/>

                    <label for="location">Enter location</label>
                    <input type="text" placeholder=" Enter a valid city" name="location" onChange={handleLocationChange} required/>

                    <label for="salary">Enter the salary</label>
                    <input type="text" placeholder="Compensation" name="salary" onChange={handleSalaryChange} required/>

                    <label for="duration">Estimated duration</label>
                    <input type="text" placeholder=" Enter the duration" name="duration" onChange={handleDurationChange} required/>

                    <p>Select a category</p>
                    <input type="checkbox" name="cleaning" value="clean" checked={clean} onChange={() => {setClean(!clean)} }/>Cleaning<br/>      
                    <input type="checkbox" name="yard_work" value="yard_work" onChange={() => {setYard(!yard_work)} }/>Yard work<br/>      
                    <input type="checkbox" name="assembly" value="assembling" onChange={() => {setAssembly(!assembly)} }/>Assembling furniture<br/>  
                    <input type="checkbox" name="shopping" value="shopping" onChange={() => {setShopping(!shopping)} }/>Shopping<br/>  
                    <input type="checkbox" name="pets" value="pets" onChange={() => {setPets(!pets)} }/>pets<br/> 
                    <input type="checkbox" name="home_repair" value="home_repair" onChange={() => {setHomeRepair(!home_repair)} }/>home repair<br/> 
                    <input type="checkbox" name="moving" value="moving" onChange={() => {setMoving(!moving)} }/>moving<br/> 
                    <input type="checkbox" name="transport" value="transport" onChange={() => {setTransport(!transport)} } />transport<br/>
                    <input type="checkbox" name="electronics" value="electronics" onChange={() => {setElectronics(!electronics)} }/>electronics<br/>  

                <br/>
                <Link to="/task"> <button type="button" className="button" onClick={handleSubmit}>Create</button></Link>
             </div>
        </form>
    </div>     
    )
    
}


export default NewTaskForm;

 