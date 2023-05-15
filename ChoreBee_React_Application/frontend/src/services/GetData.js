import axios from "axios";

const url = 'http://localhost:3001/users'
const review_url = 'http://localhost:3001/reviews'
const taskUrl = 'http://localhost:3001/tasks'

let token = null
const setToken = newToken => {
  token = `Bearer ${newToken}`
}

//gets users from the backend
const getUsers = async () => {
    const req = axios.get(url)
    const res = await req;
    return res.data;
  }

  //id pitää määrittää myöhemmin uudelleen ja tuoda tänne
  //gets a specific user from the backend
const getUser = async (userId) => {
    const req = axios.get(`${url}/${userId}`)
    const res = await req;
    return res.data;
  }

  //updates user
const updateUser = async (id, newObject) => {
    const request = axios.put(`${url}/${id}`, newObject)
    getUsers()
    const response = await request;
    return response.data;
}

//adds a new user
const addUser = async (newObject) => {
  const request = axios.post(url, newObject)
  const response = await request;
  return response.data;
}

  //gets a specific task 
const getTask = async (id) => {
    const req = axios.get(`${taskUrl}/${id}`)
    const res = await req;
    return res.data;
}

//gets all tasks
const getTasks = async () => {
  const req = axios.get(taskUrl)
  const res = await req;
  return res.data;
}

//updates task 
const updateTask = async (id, newObject) => {
  const request = axios.put(`${taskUrl}/${id}`, newObject)
  const response = await request;
  return response.data;
}

//adds a new task
const addTask = async (user_id, taskObject, userObject) => {
  const request = axios.post(taskUrl, taskObject)
  const response = await request;

  userObject.tasks.push(response.data._id)
  updateUser(user_id, userObject)
  return response.data;
}

const getReviews = async () => {
  const req = axios.get(review_url)
  const res = await req;
  return res.data;
}

const getUsersReviews = async (id) => {
  const req = axios.get(`${review_url}/${id}`)
  const res = await req;
  return res.data;
}


  export default{
    getUsers: getUsers,
    getUser: getUser,
    updateUser: updateUser,
    addUser: addUser,

    getReviews: getReviews,
    getUsersReviews: getUsersReviews,
    addTask: addTask,
    updateTask: updateTask,
    getTask: getTask,
    getTasks: getTasks

}