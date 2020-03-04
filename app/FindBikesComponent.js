import React from 'react';
import { useState, useEffect } from 'react';
import { useLocation, useParams, useHistory } from 'react-router-dom';
import { default as ErrorMessageComponent  } from "./ErrorMessageComponent";

import {Message, Label, Grid, Form, Table, Button, Segment, GridRow, GridColumn, FormField, FormGroup } from 'semantic-ui-react';

const FindRidesComponent = (props) => {
	const [ latitude, setLatitude ] = useState(35.29716300);
	const [ longitude, setLongitude ] = useState(-80.73492310);
	const [ shouldFetchAgainId, setShouldFetchAgainId ] = useState(0);
	const [ shouldFetchBycityId, setShouldFetchBycityId ] = useState(-1);
	const [ fetchedId, setFetchedId ] = useState(0);
	const [ receivedBikes, setReceivedBikes ] = useState([]);
	const [ message, setMessage ] = useState("Sorry! Not sure what happenned. You should probably call God.");
	const [ errorMessageModalOpen, setErrorMessageModalOpen ] = useState(false);
	const [modalButtonRef] = useState(React.createRef());
	const [ displayed, setDisplayed ] = useState();
	const [ cityCode, setCityCode ] = useState("CLT");

	useEffect(() => {
		async function findBicycles(){
			let postBody = {
				"latitude": latitude,
				"longitude": longitude
			}

			let fetchedBicycles = await fetch(`http://localhost:3000/bicycles/find`,{
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
	},[shouldFetchAgainId]);

	useEffect(() => {
		if (shouldFetchBycityId < 0) return
		async function findBicyclesInCity(){
			let postBody = {
				"city": cityCode
			}

			let fetchedBicycles = await fetch(`http://localhost:3000/bicycles/city/show`,{
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
		findBicyclesInCity();
	},[shouldFetchBycityId]);

	useEffect(() => {
		console.log(receivedBikes);
		
	},[fetchedId])

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

	return (
		<Grid columns={16}>
			<GridRow columns={16}>
				<GridColumn width={16}>
					<Segment style={{width:'inherit'}}>
						<Form>
							<FormGroup>
								<FormField>
									<Label size="large">Enter latitude</Label>
									<input  placeholder="Type Latitude"  value={latitude} onChange={(e) => {
										setLatitude(e.target.value);
									}}/>
								</FormField>
								<FormField>
									<Label size="large">Enter longitude</Label>
									<input  placeholder="Type Longitude"  value={longitude} onChange={(e) => {
										setLongitude(e.target.value);
									}}/>
								</FormField>
								<FormField>
									<Label size="large">Enter city code</Label>
									<input value={cityCode} onChange={(e) => {
										setCityCode(e.target.value);
									}}/>
								</FormField>
							</FormGroup>
							<FormGroup>
								<FormField>
									<Button onClick = {() => setShouldFetchAgainId(shouldFetchAgainId + 1)}>Find By Location</Button>
								</FormField>
								<FormField>
									<Button onClick = {() => setShouldFetchBycityId(shouldFetchBycityId + 1)}>Find By City</Button>
								</FormField>
							</FormGroup>
						</Form>
					</Segment>
				</GridColumn>
			</GridRow>
			<GridRow>
			<GridColumn>
				{displayed}
			</GridColumn>
			</GridRow>
			{loadAllBikeTypes()}
			
			<ErrorMessageComponent ref={modalButtonRef} open={errorMessageModalOpen} errorMessage={message} closeModal={() => setErrorMessageModalOpen(false)}></ErrorMessageComponent>
		</Grid>
	);

}

export default FindRidesComponent;