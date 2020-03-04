import React from 'react';
import { useState, useEffect } from 'react';
import { useLocation, useParams, useHistory } from 'react-router-dom';
import { default as ErrorMessageComponent  } from "./ErrorMessageComponent";
import { default as GridRowMessageComponent } from "./UtilComponents"

import {Message, Label, Grid, Form, Table, Button, Segment, GridRow, GridColumn, FormField, FormGroup, FormDropdown } from 'semantic-ui-react';

const RideComponent = (props) => {
	const [ receivedBikes, setReceivedBikes ] = useState([]);
	const [ shouldFetchByStatusCityId, setShouldFetchByStatusCityId ] = useState(0);

	const [ fetchedId, setFetchedId ] = useState(0);
	const [ fetchedRidesId, setFetchedRidesId ] = useState(0);
	
	const [ shouldFetchRidesId, setShouldFetchRidesId ] = useState(0);
	const [ receivedRides, setReceivedRides ] = useState([]);
	
	const [ message, setMessage ] = useState("Sorry! Not sure what happenned. You should probably call God.");
	const [ errorMessageModalOpen, setErrorMessageModalOpen ] = useState(false);
	const [modalButtonRef] = useState(React.createRef());
	
	const [ displayed, setDisplayed ] = useState();
	const [ cityCode, setCityCode ] = useState("CLT");
	const [ statusCode, setStatusCode ] = useState("available");
	const [ customerId, setCustomerId ] = useState(1);
	const [ endLocation, setEndLocation ] = useState({
		location_name: "PopMartin Student Union",
		latitude: 35.29716300,
		longitude: -80.73492310
	});
	const endLocationOptions = [
		{
			location_name: "PopMartin Student Union",
			latitude: 35.29716300,
			longitude: -80.73492310
		},
		{
			location_name: "Walmart Supercentre",
			latitude: 35.30038350,
			longitude: -80.72713180
		},
		{
			location_name: "Charlotte Country Club",
			latitude: 35.25717930,
			longitude: -80.74538290
		},
		{
			location_name: "Harris Teeter",
			latitude: 35.30038350,
			longitude: -80.72713180
		},
		{
			location_name: "The Public Theatre",
			latitude: 40.72549900,
			longitude: -73.98754440
		},
		{
			location_name: "Death & Company",
			latitude: 40.72545300,
			longitude: -73.98453030
		},
		{
			location_name: "Oda House",
			latitude: 40.72545300,
			longitude: -73.98453030
		},
		{
			location_name: "Roosevelt Park",
			latitude: 37.34852950,
			longitude:-121.87474030
		},
		{
			location_name: "Chavelas Restaurant",
			latitude: 37.32659110,
			longitude: -121.88603060
		},
		{
			location_name: "SAP Centre",
			latitude: 37.32973930,
			longitude: -121.89331550
		}
	];

	const statusOptions = ["in use", "available", "damaged", "damaged - ready to move", "damaged - sent for repair", "repaired - ready to move"];

	useEffect(() => {
		async function findBicycles(){
			let postBody = {
				"city": cityCode,
				"status": statusCode
			}

			let fetchedBicycles = await fetch(`http://localhost:3000/bicycles/find/status`,{
                method: 'POST',
                headers:{
                    'Content-Type': 'application/json'
                },
                cache: 'no-cache',
                body: JSON.stringify(postBody)
			})
			.then(
                (successRes) => {
					return successRes
				},
                (failureRes) => {
					setReceivedBikes([]); 
					return failureRes},
            )
            .then(
                (resolvedRes) => {
					return resolvedRes.json()},
            )
            .catch((error) => {
				// console.log(error);
				setReceivedBikes([]);
				setMessage("Can not fetch results. Some error occurred")
				setErrorMessageModalOpen(true);
			});
			if (fetchedBicycles.status == "ok"){
				setReceivedBikes(fetchedBicycles.result);
				setFetchedId(fetchedId + 1);
			}else if(fetchedBicycles.status == "error"){
				setReceivedBikes([]);
				setMessage(fetchedBicycles.error || fetchedBicycles.errorFull);
				setErrorMessageModalOpen(true);
			}
		}
		findBicycles();
	},[shouldFetchByStatusCityId]);

	useEffect(() => {
		async function findRides(){
			let postBody = {
				"city": cityCode
			}

			let fetchedRides = await fetch(`http://localhost:3000/rides/city/show`,{
                method: 'POST',
                headers:{
                    'Content-Type': 'application/json'
                },
                cache: 'no-cache',
                body: JSON.stringify(postBody)
			})
			.then(
                (successRes) => {
					return successRes
				},
                (failureRes) => {
					setReceivedRides([]);
					return failureRes},
            )
            .then(
                (resolvedRes) => {
					return resolvedRes.json()},
            )
            .catch((error) => {
				// console.log(error);
				setReceivedRides([]);
				setMessage("Can not fetch results. Some error occurred")
				setErrorMessageModalOpen(true);
			});
			if (fetchedRides.status == "ok"){
				setReceivedRides(fetchedRides.result);
				setFetchedRidesId(fetchedRidesId + 1);
			}else if(fetchedRides.status == "error"){
				setReceivedRides([]);
				setMessage(fetchedRides.error || fetchedRides.errorFull);
				setErrorMessageModalOpen(true);
			}
		}
		findRides();
	},[shouldFetchRidesId]);

	useEffect(() => {
		console.log("receivedBikes", receivedBikes);
	},[fetchedId])

	useEffect(() => {
		console.log("receivedRides", receivedRides);
	},[fetchedRidesId])

	const callStartRideProcedure = (bicycleId, customerId) => {
		async function startRide(){
			let postBody = {
				"bicycle_id": bicycleId,
				"customer_id": customerId
			}

			let rideStarted = await fetch(`http://localhost:3000/rides/city/start`,{
                method: 'POST',
                headers:{
                    'Content-Type': 'application/json'
                },
                cache: 'no-cache',
                body: JSON.stringify(postBody)
			})
			.then(
                (successRes) => {
					return successRes
				},
                (failureRes) => {
					return failureRes
				},
            )
            .then(
                (resolvedRes) => {
					return resolvedRes.json()},
            )
            .catch((error) => {
				setMessage("Could not start ride")
				setErrorMessageModalOpen(true);
			});
			if (rideStarted.status == "ok"){
				setShouldFetchRidesId(shouldFetchRidesId + 1);
				setShouldFetchByStatusCityId(shouldFetchByStatusCityId + 1);
			}else if(rideStarted.status == "error"){
				setMessage(rideStarted.error || rideStarted.errorFull);
				setErrorMessageModalOpen(true);
			}
		}
		startRide();
	}

	const callEndRideProcedure = (rideId) => {
		
		let postBodyCopy = {
			"ride_id": rideId,
			"loc_name": endLocation.location_name,
			"loc_lat": endLocation.latitude,
			"loc_long": endLocation.longitude
		}
		
		console.log("SENDING in body for end ride endpoint", postBodyCopy);
		async function endRide(){
			let postBody = {
				"ride_id": rideId,
				"loc_name": endLocation.location_name,
				"loc_lat": endLocation.latitude,
				"loc_long": endLocation.longitude
			}

			let rideEnded = await fetch(`http://localhost:3000/rides/city/end`,{
                method: 'POST',
                headers:{
                    'Content-Type': 'application/json'
                },
                cache: 'no-cache',
                body: JSON.stringify(postBody)
			})
			.then(
                (successRes) => {
					return successRes
				},
                (failureRes) => {
					return failureRes
				},
            )
            .then(
                (resolvedRes) => {
					return resolvedRes.json()},
            )
            .catch((error) => {
				setMessage("Could not end ride")
				setErrorMessageModalOpen(true);
			});
			if (rideEnded.status == "ok"){
				setShouldFetchRidesId(shouldFetchRidesId + 1);
				setShouldFetchByStatusCityId(shouldFetchByStatusCityId + 1);
			}else if(rideEnded.status == "error"){
				setMessage(rideEnded.error || rideEnded.errorFull);
				setErrorMessageModalOpen(true);
			}
		}
		endRide();

	}

	const loadTableBody = (status) => {
		if (receivedBikes && receivedBikes.length > 0){
			let filteredBikes = receivedBikes.filter((v) => v.bic_status == status);
			if (filteredBikes.length < 1) return
			let tableLabel = <Message size="large" key={`bike-${status}-table-label`}>{`${status}`}</Message>
			let tableBody = (
				<Table key={`bike-${status}-table`}>
					<Table.Header>
						<Table.Row>
							<Table.HeaderCell>Bicycle Id</Table.HeaderCell>
							<Table.HeaderCell>Bike Status</Table.HeaderCell>
							<Table.HeaderCell>Bicycle Type</Table.HeaderCell>
							<Table.HeaderCell>Location</Table.HeaderCell>
							<Table.HeaderCell>Distance</Table.HeaderCell>
							<Table.HeaderCell>City</Table.HeaderCell>
						</Table.Row>
					</Table.Header>
					<Table.Body>
						{
							filteredBikes.map((row, i) => 
								<Table.Row key={`bike-${status}-${i}`}>
									<Table.Cell>{row.bicycle_id}</Table.Cell>
									<Table.Cell>{row.bic_status}</Table.Cell>
									<Table.Cell>{row.bicycle_type}</Table.Cell>
									<Table.Cell>{row.loc_name}</Table.Cell>
									<Table.Cell>{`Approx: ${Math.ceil(row.distance) || String(1)} miles`}</Table.Cell>
									<Table.Cell>{row.city}</Table.Cell>
									{
										status == "available" &&
										<Table.Cell>
											<Button
												onClick = {() => callStartRideProcedure(row.bicycle_id, customerId)}
											>Ride It</Button>
										</Table.Cell>
									}
								</Table.Row>
							)
						}
					</Table.Body>
				</Table>
			)
			return [tableLabel, tableBody];
		}
	}

	const loadRidesTableBody = (type) => {

		if (receivedRides && receivedRides[type] && receivedRides[type].length > 0){
			let filteredRides = receivedRides[type];
			if (filteredRides.length < 1) return
			let tableLabel = <Message size="large" key={`ride-${type}-table-label`}>{`${type}`}</Message>
			let tableBody = (
				<Table key={`bike-${type}-table`}>
					<Table.Header>
						<Table.Row>
							<Table.HeaderCell>Ride City</Table.HeaderCell>
							<Table.HeaderCell>Ride Id</Table.HeaderCell>
							<Table.HeaderCell>Bicycle Id</Table.HeaderCell>
							<Table.HeaderCell>Start Time</Table.HeaderCell>
							<Table.HeaderCell>Start Location</Table.HeaderCell>
							<Table.HeaderCell>End Time</Table.HeaderCell>
							<Table.HeaderCell>End Location</Table.HeaderCell>
							<Table.HeaderCell>Ride Cost</Table.HeaderCell>
							<Table.HeaderCell>Bicycle Type</Table.HeaderCell>
						</Table.Row>
					</Table.Header>
					<Table.Body>
						{
							filteredRides.map((row, i) => 
								<Table.Row key={`bike-${type}-${i}`}>
									<Table.Cell>{row.city}</Table.Cell>
									<Table.Cell>{row.ride_id}</Table.Cell>
									<Table.Cell>{row.bicycle_id}</Table.Cell>
									<Table.Cell>{row.start_time}</Table.Cell>
									<Table.Cell>{row.start_location}</Table.Cell>
									<Table.Cell>{row.end_time}</Table.Cell>
									<Table.Cell>{row.end_location}</Table.Cell>
									<Table.Cell>{`$${row.cost}`}</Table.Cell>
									<Table.Cell>{row.bicycle_type}</Table.Cell>
									{
										type == "ongoing" &&
										<Table.Cell>
											<Button
												onClick = {() => callEndRideProcedure(row.ride_id)}
											>End Ride</Button>
										</Table.Cell>
									}
								</Table.Row>
							)
						}
					</Table.Body>
				</Table>
			)
			return [tableLabel, tableBody];
		}
	}

	const loadAllBikeTypes = () => {
		if (receivedBikes && receivedBikes.length > 0){
			return ["in use", "available", "damaged", "damaged - ready to move", "damaged - sent for repair", "repaired - ready to move"].map( v => {
				return (
					<GridRow columns={16} key={`bike-${v}-gridcolumn`}>
						<GridColumn width={16}>
							{ loadTableBody(v) }
						</GridColumn>
					</GridRow>
				);
			})
		}else{
			return (
				<Message key={'no-bikes'} size="large">
					No Bikes Found
				</Message>	
			)
		}
	}

	const loadAllRides = () => {
		if (receivedBikes && receivedBikes.length > 0){
			return ["ongoing", "finished" ].map( v => {
				return (
					<GridRow columns={16} key={`rides-${v}-gridcolumn`}>
						<GridColumn width={16}>
							{ loadRidesTableBody(v) }
						</GridColumn>
					</GridRow>
				);
			})
		}else{
			return (
				<Message key={'no-rides'} size="large">
					No Rides Found
				</Message>	
			)
		}
	}

	return (
		<Grid columns={16}>
			<GridRow columns={16}>
				<GridColumn width={16}>
					<Segment style={{width:'inherit'}}>
						<Form>
							<FormGroup>
								<Form.Select
									options={statusOptions.map((v)=> Object.assign({},{key:v,value:v,text:v}))}
									onChange={(e,{value}) => setStatusCode(value)}
									value={statusCode}
									label={<Label size="large">Select status for filtering bikes in the city</Label>}
								/>
								<FormField>
									<Label size="large">Enter city code</Label>
									<input value={cityCode} onChange={(e) => {
										setCityCode(e.target.value);
									}}/>
								</FormField>
								<Form.Select
									options={endLocationOptions.map((v)=> Object.assign({},{key:v.location_name,value:v,text:v.location_name}))}
									onChange={(e,{value}) => setEndLocation(value)}
									value={endLocation}
									label={<Label size="large">Select end location for ride</Label>}
								/>
								<FormField>
									<Label size="large">Enter customer id</Label>
									<input value={customerId} onChange={(e) => {
										setCustomerId(e.target.value);
									}}/>
								</FormField>
							</FormGroup>
							<FormGroup>
								<FormField>
									<Button onClick = {() => setShouldFetchByStatusCityId(shouldFetchByStatusCityId + 1)}>Show By Status</Button>
								</FormField>
							</FormGroup>
						</Form>
					</Segment>
				</GridColumn>
			</GridRow>
			<GridRowMessageComponent size="small" message={`Bikes within ${cityCode} are shown below`}/>
			{loadAllBikeTypes()}
			<GridRowMessageComponent size="small" message={`Rides within ${cityCode} are shown below`}/>
			{loadAllRides()}
			<ErrorMessageComponent ref={modalButtonRef} open={errorMessageModalOpen} errorMessage={message} closeModal={() => setErrorMessageModalOpen(false)}></ErrorMessageComponent>
		</Grid>
	);

}

export default RideComponent;