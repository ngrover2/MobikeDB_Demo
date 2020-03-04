import React from 'react';
import { Button, Modal, Grid, Segment, Label, Table } from 'semantic-ui-react';
var { reject, resolve } = Promise;

const BicycleDBRow = (props) => {
    return (
        <Grid.Row columns={12} style={{display:"flex"}}>
            <Grid.Column width={4}>
                <Label>
                    {props.location}
                </Label>
            </Grid.Column>
            <Grid.Column width={4}>
                {
                    props.bic_status == "Available" &&
                        <Label color="green" horizontal>
                            {props.bic_status}
                        </Label>
                    ||
                        <Label color="red" horizontal>
                            {props.bic_status}
                        </Label>
                }                
            </Grid.Column>
        </Grid.Row>
    );
}

const AccHistoryDBRow = (props) => {
    var formatted_updated_timestamp = null;
    try{
        var updated_timestamp = new Date(props.updated_timestamp);
        formatted_updated_timestamp = String(updated_timestamp.getMonth()) + '/' + String(updated_timestamp.getDate()) + '/' + String(updated_timestamp.getFullYear());
        
    }catch{

    }
    return (
        <Grid>
            <Grid.Row columns={12}>
                <Grid.Column width={4}>
                    {"Date: "}
                    <Label as='a' color="grey">
                        {formatted_updated_timestamp}
                    </Label>
                </Grid.Column>
                <Grid.Column width={4}>
                    {"Current Balance: "}
                    <Label color="green" horizontal>
                        {"$" + String(props.balance)}
                    </Label>     
                </Grid.Column>
                <Grid.Column width={4}>
                    {"Behavior Credit Score: "}
                    <Label circular color="teal">
                        {props.behavior_credit}
                    </Label>
                </Grid.Column>
            </Grid.Row>
        </Grid>
    );
}

const DamageReportDBRow = (props) => {
    var formatted_reported_date = null;
    try{
        var reported_date = new Date(props.reported_time);
        formatted_reported_date = String(reported_date.getMonth()) + '/' + String(reported_date.getDate()) + '/' + String(reported_date.getFullYear());
        
    }catch{

    }
    return (
        <Grid>
            <Grid.Row columns={12}>
                <Grid.Column width={2}>
                    <Label color="green" horizontal>
                        {"Bike " + String(props.bicycle_id)}
                    </Label>     
                </Grid.Column>
                <Grid.Column width={4}>
                    <Label color="red" horizontal>
                        {props.damage_type}
                    </Label>
                </Grid.Column>
                <Grid.Column width={2}>
                    {
                        formatted_reported_date && 
                        <Label color="blue" horizontal>
                            {formatted_reported_date}
                        </Label>
                    }
                </Grid.Column>
            </Grid.Row>
        </Grid>
    );
}


class DisplayGreetingsComponent extends React.Component{
    constructor(props){
        super(props)
        this.state = {
            bicycles:[],
            history:[],
            damagereports:[],
            modalHeader:"",
            modalResulsAreFor:"",
            modalOpen:false,
            moverequests:[],
            bikesadded:[],
            showaddedplans:[]
        }
        this.getDataFromDB = this.getDataFromDB.bind(this);
        this.loadModalContent = this.loadModalContent.bind(this);
    }

    loadModalContent(){
        switch(this.state.modalResulsAreFor){
            case "bicycles": return this.state.bicycles;
            case "history": return this.state.history;
            case "damagereports": return this.state.damagereports;
            case "moverequests": return this.state.moverequests;
            case "bikesadded": return this.state.bikesadded;
            case "showaddedplans": return this.state.showaddedplans;
            default: return;
        }
    }
    

    getDataFromDB(table){
        var setDbResults = function(jsonResult, stateField){
            var dbRows = null;
            console.log("jsonResult",jsonResult);
            if (jsonResult == null){
                return;    
            }
            console.log(stateField);
            switch(stateField){
                
                case "bicycles":{
                    dbRows = jsonResult.result.map((row, i) => <BicycleDBRow key={i} {...row}/>);
                }
                break;
                case "history":{
                    dbRows = jsonResult.result.map((row, i) => <AccHistoryDBRow key={i} {...row}/>);
                }
                break;
                case "damagereports":{
                    dbRows = jsonResult.result.map((row, i) => <DamageReportDBRow key={i} {...row}/>);
                }
                break;
                case "moverequests":{
                    dbRows = (
                    <Table>
                        <Table.Header>
                            <Table.Row>
                                <Table.HeaderCell>Request_Id</Table.HeaderCell>
                                <Table.HeaderCell>Bicycle_Id</Table.HeaderCell>
                                <Table.HeaderCell>Pick up Location</Table.HeaderCell>
                                <Table.HeaderCell>Drop Off Location</Table.HeaderCell>
                                <Table.HeaderCell>Created By Moderator</Table.HeaderCell>
                            </Table.Row>
                        </Table.Header>
                        <Table.Body>
                            {jsonResult.result.map((row, i) => 
                                <Table.Row key={i}>
                                    <Table.Cell>{row.request_id}</Table.Cell>
                                    <Table.Cell>{row.bicycle_id}</Table.Cell>
                                    <Table.Cell>{row.pickup_loc_name}</Table.Cell>
                                    <Table.Cell>{row.dropoff_loc_name}</Table.Cell>
                                    <Table.Cell>{row.moderator_name}</Table.Cell>
                                </Table.Row>
                            )}
                        </Table.Body>
                        
                    </Table>
                    );
                    console.log(dbRows);
                }
                break;
                case "bikesadded":{
                    dbRows = (
                    <Table>
                        <Table.Header>
                            <Table.Row>
                                <Table.HeaderCell>Bike Id</Table.HeaderCell>
                                <Table.HeaderCell>Added at timestamp</Table.HeaderCell>
                                <Table.HeaderCell>Moderator Name</Table.HeaderCell>
                            </Table.Row>
                        </Table.Header>
                        <Table.Body>
                            {jsonResult.result.map((row, i) => 
                                <Table.Row key={i}>
                                    <Table.Cell>{row.bicycle_id}</Table.Cell>
                                    <Table.Cell>{row.added_at}</Table.Cell>
                                    <Table.Cell>{row.moderator_name}</Table.Cell>
                                </Table.Row>
                            )}
                        </Table.Body>
                    </Table>
                    );
                    console.log(dbRows);
                }
                break;
                case "showaddedplans":{
                    dbRows = (
                    <Table>
                        <Table.Header>
                            <Table.Row>
                                <Table.HeaderCell>Plan Id</Table.HeaderCell>
                                <Table.HeaderCell>Plan Name</Table.HeaderCell>
                                <Table.HeaderCell>Plan Cost Per Month</Table.HeaderCell>
                                <Table.HeaderCell>Plan Valid in City</Table.HeaderCell>
                                <Table.HeaderCell>Moderator Name</Table.HeaderCell>
                            </Table.Row>
                        </Table.Header>
                        <Table.Body>
                            {jsonResult.result.map((row, i) => 
                                <Table.Row key={i}>
                                    <Table.Cell>{row.plan_id}</Table.Cell>
                                    <Table.Cell>{row.plan_name}</Table.Cell>
                                    <Table.Cell>{row.cost}</Table.Cell>
                                    <Table.Cell>{row.valid_in_city}</Table.Cell>
                                    <Table.Cell>{row.moderator_name}</Table.Cell>
                                </Table.Row>
                            )}
                        </Table.Body>
                    </Table>
                    );
                    console.log(dbRows);
                }
                break;
                default:return;
            }
            this.setState({
                [stateField]:dbRows,
                modalResulsAreFor:stateField
            },()=>document.getElementById("invisiblebutton").click());
        }.bind(this);
        
        var results = null;
        switch(table){
            case "bicycles":{
                this.setState({modalHeader:"Showing bicycles near you!"});
                // document.getElementById("invisiblebutton").click();
                results = fetch("http://localhost:3000/bicycles");
            }
            break;
            case "history":{
                this.setState({modalHeader:"Showing your account history"});
                // document.getElementById("invisiblebutton").click();
                results = fetch("http://localhost:3000/accounthistory");
            }
            break;
            case "damagereports":{
                this.setState({modalHeader:"Showings some Damage Reports"});
                // document.getElementById("invisiblebutton").click();
                results = fetch("http://localhost:3000/damagereports");
            }
            break;
            case "moverequests":{
                this.setState({modalHeader:"Showings some Move Requests"});
                // document.getElementById("invisiblebutton").click();
                results = fetch("http://localhost:3000/moverequests");
            }
            break;
            case "bikesadded":{
                this.setState({modalHeader:"Showings Bikes added by Content Moderator with Id 2: Tina Brown"});
                // document.getElementById("invisiblebutton").click();
                results = fetch("http://localhost:3000/bikesadded");
            }
            break;
            case "showaddedplans":{
                this.setState({modalHeader:"Showings Prepaid Plans added by Content Moderator with Id 2: Tina Brown"});
                // document.getElementById("invisiblebutton").click();
                results = fetch("http://localhost:3000/showaddedplans");
            }
            break;
            default:return;
        }

        results
            .then((res) => {
                console.log("Resolving")
                console.log(res);
                return Promise.resolve(res)
                
            },(error) => {
                return Promise.reject(error)
            })
            .then((resolved)=>{
                if (resolved.status == 200){
                    return resolved.json()
                }
            })
            .then((jsonResult)=>{
                if (jsonResult){
                    console.log("resolved", jsonResult);
                    // const dbRows = jsonResult.result.map((row, i) => <BicycleDBRow key={i} {...row}/>);
                    // console.log(dbRows)
                    setDbResults(jsonResult, table);
                }else{
                    console.log("status is 200")
                    // setDbResults(<div>{`No Results Returned`}</div>);
                    setDbResults();
                }
            })
            .catch((error)=>{
                // setDbResults(<div>{`Error Occurred: ${error.message}`}</div>);
                setDbResults();
            })
    }
    
    render(){
    
        return (
                <Grid stackable={true} centered={true} divided verticalAlign={"middle"} style={{ width:"inherit", height:"inherit" }}>
                    <Grid.Row style={{ width:"inherit", height:"inherit" }}>
                        <Grid.Column computer={4} largeScreen={4} mobile={12} tablet={4}>
                            <div style={{ display:"flex" }}>
                                <Segment color='red' size={"massive"} style={{ margin:"auto" }}>
                                    <Button onClick={() => this.getDataFromDB("bicycles")}>
                                        {"Show Bikes Near Me"}
                                    </Button>
                                </Segment>
                            </div>
                        </Grid.Column>
                        <Grid.Column computer={4} largeScreen={4} mobile={12} tablet={4}>
                            <div style={{ display:"flex" }}>
                                <Segment color='red' size={"massive"} style={{ margin:"auto" }}>
                                    <Button onClick={() => this.getDataFromDB("history")}>
                                        {"Show My Account History"}
                                    </Button>
                                </Segment>
                            </div>
                        </Grid.Column>
                        <Grid.Column computer={4} largeScreen={4} mobile={12} tablet={4}>
                            <div style={{ display:"flex" }}>
                                <Segment color='red' size={"massive"} style={{ margin:"auto" }}>
                                    <Button onClick={() => this.getDataFromDB("damagereports")}>
                                        {"Show Damage Reports"}
                                    </Button>
                                </Segment>
                            </div>
                        </Grid.Column>
                    </Grid.Row>
                    <Grid.Row style={{ width:"inherit", height:"inherit" }}>
                        <Grid.Column computer={4} largeScreen={4} mobile={12} tablet={4}>
                            <div style={{ display:"flex" }}>
                                <Segment color='red' size={"massive"} style={{ margin:"auto" }}>
                                    <Button onClick={() => this.getDataFromDB("moverequests")}>
                                        {"Show Move Requests"}
                                    </Button>
                                </Segment>
                            </div>
                        </Grid.Column>
                        <Grid.Column computer={4} largeScreen={4} mobile={12} tablet={4}>
                            <div style={{ display:"flex" }}>
                                <Segment color='red' size={"massive"} style={{ margin:"auto" }}>
                                    <Button onClick={() => this.getDataFromDB("bikesadded")}>
                                        {"Show Bikes added by Tina Brown"}
                                    </Button>
                                </Segment>
                            </div>
                        </Grid.Column>
                        <Grid.Column computer={4} largeScreen={4} mobile={12} tablet={4}>
                            <div style={{ display:"flex" }}>
                                <Segment color='red' size={"massive"} style={{ margin:"auto" }}>
                                    <Button onClick={() => this.getDataFromDB("showaddedplans")}>
                                        {"Show Prepaid Plans added by Tina Brown"}
                                    </Button>
                                </Segment>
                            </div>
                        </Grid.Column>
                    </Grid.Row>
                    <Modal trigger={
                        <Button id="invisiblebutton" style={{visibility:"hidden"}} onClick={() => this.setState({modalOpen:true})}>
                            {"Show Damage Reports"}
                        </Button>
                    }
                    open={this.state.modalOpen}
                    >
                        <Modal.Header>
                            {this.state.modalHeader}
                        </Modal.Header>
                        <Modal.Content>
                            {this.loadModalContent()}
                        </Modal.Content>
                        <Modal.Actions>
                            <Button onClick={()=> this.setState({modalOpen:false})}>
                                {"Ok"}
                            </Button>
                        </Modal.Actions>
                    </Modal>
                </Grid>
        );
    }
}

export default DisplayGreetingsComponent;