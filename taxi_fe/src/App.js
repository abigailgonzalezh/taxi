import React from 'react';
import Reflux from 'reflux';
import axios from 'axios';

const mbxClient = require('@mapbox/mapbox-sdk');
const mbxGeocoding = require('@mapbox/mapbox-sdk/services/geocoding');

const baseClient = mbxClient({ accessToken: "pk.eyJ1IjoiYW5kcmVyZHo3IiwiYSI6ImNrMXMwZTBldDA0MnQzbHFtanc5MnMwNnEifQ.lzUc0gGUPfPgG-ktKXL1_A" });
const geocoding = mbxGeocoding(baseClient);

let Actions = Reflux.createActions([{
    submitBookingRequest: {children: ['completed', 'failed']}
}]);

Actions.submitBookingRequest.listen(function(pickup_address, dropoff_address) {
  var that = this;
  geocoding.reverseGeocode({
    query: [-98.2331861, 19.0163279],
    limit: 1
  })
    .send()
    .then(response => {
      console.log("HERE");
      console.log(response.body);
    });

  axios.post('http://localhost:4000/api/bookings', {
        pickup_address: pickup_address,
        dropoff_address: dropoff_address
    })
    .then(res => that.completed(res.data))
    .catch(this.failed);
});

class AppStore extends Reflux.Store {
  constructor() {
    super();
    this.state = {pickup_address: "Vía Atlixcáyotl 5718, Puebla, México", dropoff_address: "", messages: [] };
    this.listenables = Actions;
  }
  onSubmitBookingRequestCompleted(response) {
    console.log("response", response);
    this.setState({messages: [...this.state.messages, response.msg]});
  }
  onSubmitBookingRequestFailed() {
    console.error("oops");
  }
}

class App extends Reflux.Component {
  constructor(props) {
    super(props);
    this.store = AppStore;
  }
  render() {
    return (
      <div>
          <div>
            <label>Pickup address </label>
            <input onChange={ ev => this.setState({pickup_address: ev.target.value}) } value={this.state.pickup_address}></input>
          </div>
          <div>
            <label>Drop off address </label>
            <input onChange={ ev => this.setState({dropoff_address: ev.target.value}) } value={this.state.dropoff_address}></input>
          </div>
          <button onClick={ () => Actions.submitBookingRequest(this.state.pickup_address, this.state.dropoff_address) }>Submit booking request</button>
      </div>
    );
  }
}

export default App;