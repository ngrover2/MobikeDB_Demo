import React from 'react';
import { useState } from 'react';
import {
	BrowserRouter as Router,
	Switch,
	Route,
	Link,
	useParams
} from "react-router-dom";
import { Image, Header ,Segment ,Sidebar, Menu, Label, Icon, Button, Divider } from 'semantic-ui-react';
const linkLabelStyle = { 
	marginTop:"1rem",
	fontSize:"1.15rem"
}

const SidebarComponent = (props) => {

	const { pid } = useParams()
	return(
		<Sidebar.Pushable as={Segment}>
			<Sidebar
				as={Menu}
				animation='scale down'
				icon='labeled'
				inverted
				vertical
				visible={props.visible}
				width='thin'
			>
				<Menu.Item>
					<Link to={`/storedprocs`}>
						<Icon name='home'/>
						<div style = {linkLabelStyle}>Procedures</div>
					</Link>
				</Menu.Item>
				<Menu.Item>
					<Link to={`/storedfuncs`}>
						<Icon name='sticky note'/>
						<div style = {linkLabelStyle}>Functions</div>
					</Link>
				</Menu.Item>
				<Menu.Item>
					<Link to={`/trigs`}>
						<Icon name='sticky note'/>
						<div style = {linkLabelStyle}>Triggers</div>
					</Link>
				</Menu.Item>
			</Sidebar>
			<Sidebar.Pusher style={props.pushStyle}>
				{props.children}
			</Sidebar.Pusher>
		</Sidebar.Pushable>
	);
}

export default SidebarComponent;