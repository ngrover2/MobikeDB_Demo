import React from 'react'
import { useState, useEffect } from 'react';
import { Form, Divider, Grid, Message, Header, Label, Segment } from 'semantic-ui-react';
export const FullWidthDivider = (props) => <Divider id="visiblefullwidthdivider"/>

export const questionWeights = [ "Extremely Important", "Very Important", "Somewhat Important", "Little Important", "Not Important" ];
export const qtypeToReadableMapping = {
	text: "Text", 
	multiplechoice: "Multiple Choice",
	multiplevalues: "Multiple Values", 
	singlevalue: "Single Choice", 
	schedule: "Schedule"
}

const GridRowMessageComponent = (props) => {
	return(
		<Grid.Row>
			<Grid.Column width={16}>
				<Message size={props.size || "small"} header={<Header>{props.message || ""}</Header>}/>
			</Grid.Column>
		</Grid.Row>
	);
}

export default GridRowMessageComponent;