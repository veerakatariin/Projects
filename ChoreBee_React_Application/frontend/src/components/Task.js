import Header from "./Main/Header";
import { useEffect, React, useState } from "react";
import profile from "../services/GetData.js"
import { Link } from "react-router-dom";

const TaskPage = () => {

    const [aTask, setATask] = useState([])
    const [pTask, setPTask] = useState([])

    const activeTasks = []
    const pastTasks = []

    const loggedUserJSON = window.localStorage.getItem('loggedUser')
    const userlog = JSON.parse(loggedUserJSON)

      useEffect(() => {
          profile
          .getUser(userlog.id)
          .then(res => {
            checkTaskActivity(res.tasks)
            setATask(activeTasks)
            setPTask(pastTasks)
          })
        }, [])


      const checkTaskActivity = (tasks) => {
            tasks.map(oneTask => {
                if(oneTask.active === true){
                    activeTasks.push(oneTask)
                }
                else{
                  pastTasks.push(oneTask)
                }
                setATask(oneTask)
            })
      }

      const updateTaskActivity = async (taskId) => {

        const request = profile.getTask(taskId)
        const res = await request;

        const updatedTask = {
          headline: res.headline,
          description: res.description,
          location: res.location,
          salary: res.salary,
          duration: res.duration,
          active: false,
          user: res.user_id,
          category: {

          }
        }

        profile.updateTask(taskId, updatedTask)
      }

      const edittasks = (task) => {
        window.localStorage.setItem('edittask', JSON.stringify(task))
      }
      
    return(
      
    <div Name="container">
      <div className="main-body">
      <Header />

        <div className="row gutters-sm">
            <h2>Active tasks </h2>
            <Link to="/newtask"><button className="btn btn-primary">Create a task</button></Link>
            {aTask.map(task => {
                return (
                    <div className="col-md-8">
                      <div className="card mb-3">
                        <div className="card-body">
                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Headline</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {task.headline}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Description</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {task.description}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Location</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {task.location}
                            </div>
                          </div>
                          <hr/>

                          
                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Duration</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {task.duration}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Salary</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {task.salary}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                             <div className="col-sm-3">
                              <h6 className="mb-0">Category</h6>
                            </div>
                            <div>
                            {console.log(task.headline)}
                            {Object.entries(task.category).map(item => {
                              if(item[1] === true){
                                return(
                                  <div>{item[0]}</div>
                                )
                              }
                            })}
                          </div>
                          </div>
                    
                          <hr/>
  
                          <button onClick={()=> updateTaskActivity(task._id)}>Mark as done</button>
                          <Link to="/edittask"><button onClick={() => edittasks(task)}>Edit</button></Link>
                        </div>
                      </div>
                    </div>
                )
             })
            }

            <h2>Past tasks </h2>
            {pTask.map(task => {
                return (
                    <div className="col-md-8">
                      <div className="card mb-3">
                        <div className="card-body">
                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Headline</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {task.headline}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Description</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {task.description}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Location</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {task.location}
                            </div>
                          </div>
                          <hr/>

                          
                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Duration</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {task.duration}
                            </div>
                          </div>
                          <hr/>

                          <div className="row">
                            <div className="col-sm-3">
                              <h6 className="mb-0">Salary</h6>
                            </div>
                            <div className="col-sm-9 text-secondary">
                              {task.salary}
                            </div>
                          </div>
                          <hr/>


                          <div className="row">
                             <div className="col-sm-3">
                              <h6 className="mb-0">Category</h6>
                            </div>
                            <div>
                            {console.log(task.headline)}
                            {Object.entries(task.category).map(item => {
                              if(item[1] === true){
                                return(
                                  <div>{item[0]}</div>
                                )
                              }
                            })}
                          </div>
                          </div>
                        </div>
                      </div>
                    </div>
                )
                })
            }
            </div>
        </div>
    </div>
    )
}

export default TaskPage;
