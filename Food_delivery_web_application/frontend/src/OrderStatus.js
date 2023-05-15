import React from 'react'
import styles from './OrderStatus.module.css'

export default function OrderStatus() {

let status = localStorage.getItem('status')
if (status !== null){
let status_info = JSON.parse(localStorage.getItem('user_key'))
let check_status = [] = status.split('...')


//clears order from local storage
function handleCheck(){
    localStorage.removeItem('status')
    window.location.reload()
    
}


//changes the status of the order
if (check_status[1] === status_info[0].username){
    if (check_status[0] === 'received'){

        return (
        <div className={styles.container}>
        status info: {status_info[1]} <div >Your order is awaiting confiramtion</div>Estimated delivery time: <div>45 min</div></div>
        
    )}
    if (check_status[0] === 'preparing'){

        return (
        <div className={styles.container}>
        status info: {check_status[0]} <div>Your order is being prepared</div>Estimated delivery time: <div>30 min</div></div>
        
    )}
    if (check_status[0] === 'delivering'){

        return (
        <div className={styles.container}>
        status info: {check_status[0]} <div>Your order is being delivered</div>Estimated delivery time: <div>10 min</div></div>
        
    )}

        
        else{
            
        return (<div>status info: {check_status[0]} <div>Your order has arrived</div>CONFRIM ARRIVAL<div><button onClick={() => handleCheck()}>CONFIRM</button></div></div>
            
        )}
    }
    else{
        return (
            <div></div>)}
        }

    else{
    return (
        null
    )}
}
