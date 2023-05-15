import Header from "./Main/Header"
import task from "../services/GetData.js"
import { useEffect, React, useState } from "react";
import { Link } from "react-router-dom";
import ApplyForTask from "./ApplyForTask";


const Browse = () => {

    const [tasks, setTasks] = useState([])
    const [filter, setFilter] = useState([])
    const [appliedTask, setAppliedTask] = useState([])

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
        task
        .getTasks()
        .then(res => {
          setTasks(res)
        })
      }, [])

      const handleFilterChange = (event) => {
        setFilter(event.target.value)
      }  

      const applyForTask = (taskApply) => {
        setAppliedTask(taskApply)
        console.log(appliedTask)
        return(
            <ApplyForTask data={appliedTask} />
        )
      }

      const filteredByLoc = tasks
      
      //filter ? tasks.filter(task => task.location.includes(filter)) : tasks
      //filteredByLoc.length

      let length = tasks.length


    return (
    <html>
            <head>
                <link href='../styles/browse.css' rel='stylesheet' />
            </head>
    <body>
    <Header/>

    <div className="grid-container">
    <div className="itemF">
    <div className="col-md-8">
    <div className="card mb-3">
    <div className="card-body">
        <form>
        <div className="row">
            <p>Select a category</p>
            <input type="checkbox" name="cleaning" value="cleaning" onChange={() => {setClean(!clean)} } />Cleaning<br/>      
            <input type="checkbox" name="yard_work" value="yard_work" onChange={() => {setYard(!yard_work)} } />Yard work<br/>      
            <input type="checkbox" name="assembling" value="assembling" onChange={() => {setAssembly(!assembly)} } />Assembling furniture<br/>  
            <input type="checkbox" name="shopping" value="shopping" onChange={() => {setShopping(!shopping)} } />Shopping<br/>  
            <input type="checkbox" name="pets" value="pets" onChange={() => {setPets(!pets)} } />Pets<br/> 
            <input type="checkbox" name="home_repair" value="home_repair" onChange={() => {setHomeRepair(!home_repair)} } />Home Repair<br/> 
            <input type="checkbox" name="moving" value="moving" onChange={() => {setMoving(!moving)} } />Moving<br/> 
            <input type="checkbox" name="transport" value="transport" onChange={() => {setTransport(!transport)} } />Transport<br/> 
            <input type="checkbox" name="electronics" value="electronics" onChange={() => {setElectronics(!electronics)} } />Electronics<br/> 
        </div>
        <br/>
            <p>Location</p>
            <input type="text" onChange={handleFilterChange}></input>
        <br/>
            <p>Compensation range</p>
            <input type="range" name="vol" min="0" max="1000" id="myRange" defaultValue="500" />1000

        </form>
        </div></div></div>
        </div>

        <div className="grid-task">
            
        {length > 0 && filteredByLoc.map(task => {
            if(task.active === true ){
            return(
                    <div className="itemL">
                        <div className="col-md-8">
                            <div className="card mb-3">
                                <div className="card-body">

                                    <div className="row">
                                        <h4 className="col-sm-9 text-secondary">
                                            {task.headline}
                                        </h4>
                                    </div>

                                    <div className="row">
                                        <div>Description: {task.description}</div>
                                    </div>
                                    <div className="row">
                                        <div>Location: {task.location}</div>
                                    </div>
                                    <div className="row">
                                        <div>Compensation: {task.salary}</div>
                                    </div>
                                    <div className="row">
                                        <div>Duration: {task.duration}</div>
                                    </div>
                                    <div className="row">
                                        <div>Category:            
                                            {Object.entries(task.category).map(item => {
                                            if(item[1] === true){
                                                 return(
                                                <div>{item[0]}</div>
                                                )
                                            }
                                        })}</div>
                                    </div>

                                    <div className="row">
                                        <div>Creator:</div>
                                    </div>
                                    <br/>
                                </div>
                                <Link to="/applyfortask"><button  className="button" onClick={() => applyForTask(task)}>Apply</button></Link>
                                <hr/>
                </div> </div> </div>
            )
            }
        })}
        </div>
        </div>
    </body>
</html>
    )
}

export default Browse