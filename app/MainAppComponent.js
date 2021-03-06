import React from 'react';
import { useState, useEffect } from 'react';
import {
    BrowserRouter as Router,
    Switch,
    Route,
    Link,
    Redirect
  } from "react-router-dom";

import { Table, Header, Cell, Icon, Button, Grid, GridColumn, Container, Segment } from 'semantic-ui-react';
import {default as SidebarComponent } from "./SidebarComponent";
import { default as HeaderComponent } from "./AppHeaderComponent";
import { default as FindBikesComponent } from "./FindBikesComponent";
import RideComponent from './RideComponent';

export default function MainAppComponent() {
    const wHeight = window.innerHeight;
    console.log(wHeight)
    const [ sidebarVisible, setSidebarVisible ] = useState(false);
    
    const HeaderCellComponent = (props) => (<Table.HeaderCell singleLine>{props.headerName}</Table.HeaderCell>);
    var getHeaders = () => {
        const header = ["name", "email", "skill", "age"]
        var ret = []
        header.forEach((v,i) => {
            ret.push(<HeaderCellComponent key={v} headerName={v}/>);
        });
        return ret;
    }
    const headers = getHeaders();
    const appBackGroundStyle = {
        background:"linear-gradient(0deg,rgba(0,0,0,0.7),rgba(0,0,0,0.7)),url(/assets/images/background.jpg)"
        // background:"linear-gradient(0deg,rgba(0,0,0,0.7),rgba(0,0,0,0.7))"
    }

    return (
        <div>
        <Router>
            <Route path="/storedprocs">
                <SidebarComponent setVisible={setSidebarVisible} visible={sidebarVisible} pushStyle={appBackGroundStyle}>
                    <Grid style={{ background:"inherit"}}>
                        <Grid.Row>
                            <HeaderComponent setSidebarVisible={setSidebarVisible}/>
                        </Grid.Row>
                        <Grid.Row>
                            <GridColumn width={1}/>
                            <GridColumn width={14}>
                                <Switch>
                                    <Route exact={true} path={`/storedprocs/findbikes`}>
                                        <FindBikesComponent />
                                    </Route>
                                    <Route exact={true} path={`/storedprocs/rides`}>
                                        <RideComponent />
                                    </Route>
                                    <Route exact={true} path={`/trigs`}>    
                                        <Segment>{"DEMO STORED TRIGGERS"}</Segment>
                                    </Route>
                                    <Route exact={true} path={`/trigs`}>
                                        <Segment>{"DEMO STORED TRIGGERS"}</Segment>
                                    </Route>
                                    <Route
                                            path="/"
                                            children = {() => <Segment >WE ARE AT ROOT</Segment>}
                                            // children = {() => <Redirect to={"/"}/>}
                                    />
                                </Switch>
                            </GridColumn>
                            <GridColumn width={1}/>
                        </Grid.Row>
                    </Grid>
                </SidebarComponent>
            </Route>
            <Route path="/" exact={true}>
                <SidebarComponent setVisible={setSidebarVisible} visible={sidebarVisible} pushStyle={appBackGroundStyle} pid={1}>
                    <Grid style={{ background:"inherit"}}>
                        <Grid.Row>
                            <HeaderComponent setSidebarVisible={setSidebarVisible} pid={1}/>
                        </Grid.Row>
                        <Grid.Row style={{height:wHeight}}>
                            <Container style={{ display:"flex", alignItems:"center", justifyContent:"center", flexDirection:"column" }}>
                                <div style={{ fontSize:"5rem", color:"white", lineHeight:"initial" }}>Welcome to MoBike</div>
                                <div style={{ margin:"5px", fontSize:"1.5rem", color:"ghostwhite" }}>Click <Link style={{ margin:"1rem 1rem" }} to={"/storedprocs"}><Button positive>Here</Button></Link> to rent your first bike!</div>
                            </Container>
                        </Grid.Row>
                    </Grid>
                </SidebarComponent>
            </Route>
        </Router>
        </div>
    );
}