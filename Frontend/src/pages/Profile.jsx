import React, { useEffect, useState } from 'react';
import Navbar from "../components/Navbar";
import { useAuth0 } from '@auth0/auth0-react';
import axios from 'axios';
import { InlineIcon } from '@iconify/react';
import { AddCarModal } from '../components/AddCarModal';

function Profile() {
  const { user } = useAuth0();

  return (
    <div className='bg-neutral-100 min-h-screen'>
      <Navbar />
      <div className='flex flex-col mt-6 w-11/12 mx-auto md:flex-row'>
        <div className='w-full md:w-1/2'>
          <img src={user.picture} alt="" className='mx-auto md:mx-0 mt-6 rounded-full' />
          <p className='mt-4 text-center md:text-left mx-6 font-semibold'>{user.nickname}</p>
        </div>
        <div className='md:mt-10 text-pretty md:text-left'>
          <p>Name: <span>{user.nickname}</span></p>
          <p>Email Address: <span>{user.email}</span> {user.email_verified ? "verified" : "Unverified"}</p>
          <p>Joined On: <span>{user.updated_at.split('T')[0]}</span></p>
        </div>
      </div>
      <div className='mt-10'>
        <UserCars />
      </div>
    </div>
  );
}

function UserCars() {
  const [isLoading, setIsLoading] = useState(false);
  const [cars, setCars] = useState([]);
  const { user } = useAuth0();

  const onFormSubmit = async (user, values) => {
    try {
      console.log(`${import.meta.env.VITE_BACKEND_URL}/auth/setCars`, { user, values });
      const res = await axios.post(`${import.meta.env.VITE_BACKEND_URL}/auth/setCars`, { user, values });
      console.log(res.data);
    } catch (e) {
      console.error('Error setting cars:', e);
    }
  };

  useEffect(() => {
    if (user) {
      setIsLoading(true);
      const fetchCars = async () => {
        try {
          console.log(`${import.meta.env.VITE_BACKEND_URL}/auth/getCars`, { email: user.email });
          const res = await axios.get(`${import.meta.env.VITE_BACKEND_URL}/auth/getCars?email=${user.email}`);
          setCars(res.data.cars);
          console.log(res);
        } catch (e) {
          console.error('Error fetching cars:', e);
        } finally {
          setIsLoading(false);
        }
      };
      fetchCars();
    }
  },

  
  [user]);

  return(
    <div className='w-full px-4 md:px-10'>
      <div>
        <div className='flex justify-between'>
          <p className='text-xl text-slate-500'>Your cars</p>
          <AddCarModal onSubmit={onFormSubmit} />
        </div>
      </div>
      {isLoading?"Loading...":<CarsGrid cars={cars} />}
    </div>
  )
}

function CarsGrid({cars}){
  return(
    <div>
      {!cars.length?<p className='w-full text-center'>No cars to show</p>: <div>
          <div className='px-3'>
          <table className="table-auto w-full mt-3">
            <thead className='text-left'>
              <tr>
                <th>Sr No.</th>
                <th>Company</th>
                <th>Model</th>
                <th>Type</th>
                <th>Capacity</th>
              </tr>
            </thead>
            <tbody>
              {cars.map((e,i)=>{
                return(
                  <tr key={i}>
                    <td>{i+1}.</td>
                    <td>{e.Company}</td>
                    <td>{e.model}</td>
                    <td>{e.vehicleType}</td>
                    <td>{e.capacity}</td>
                  </tr>
                )
              })}
            </tbody>
          </table>
          </div>
        </div>}
    </div>
  )
}
export default Profile