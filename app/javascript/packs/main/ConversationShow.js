import React from 'react'
import axios from 'axios'
import AjaxHelper from './shared/AjaxHelper'
import DateFormat from './shared/DateFormat'

class ConversationShow extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      apiRequestHeaders: {},
      conversation_id: document.querySelector('#conversation-id').value,
      error: null,
      isLoaded: false,
      conversation: [],
      message: null
    };
  }

  componentDidMount() {
    var path = "/api/conversations/" + this.state.conversation_id
    AjaxHelper(path, this, "conversation");
  }

  handleChange = (e) => {
    this.setState({message: e.target.value})
  }

  createMessage = (e) => {
    const options = {
      method:       'post',
      url:          '/api/conversations/' + this.state.conversation_id  +'/messages',
      headers:      this.apiRequestHeaders,
      data:         {"message": this.state.message},
      responseType: 'json',
    }

    axios(options)
      .then(response => this.setState({conversation: response.data}))
      .then(
        document.querySelector('#message').value = ""
      )
      .catch(this._apiError)
  }

  _apiError = (error) => {
    console.log('Picture not loaded', error)
  }

  render() {
    const { error, isLoaded, conversation } = this.state;
    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
      return (
        <div className="container">
          <div className="row text-center">
            <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
              <h4>Conversation with {conversation.recipient}</h4>
            </div>

              { conversation.messages.length == 0 ?
                <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                  <h4>No messages</h4>
                </div>
              :
                <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                  {conversation.messages.map(message => (
                    <p>{message.user}: {message.body} {DateFormat(message.time)}</p>
                  ))}
                </div>
              }
            <br/>
            <br/>
            <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
              <textarea name="message" id="message" rows="3" cols="75" onChange={(e) => {this.handleChange(e)}}/>
              <br/>
              <button className="btn btn-outline-primary" id="send-messge" type="button" onClick={(e) => {this.createMessage(e)}}>Submit</button>
            </div>
          </div>
        </div>
      );
    }
  }
}

export default ConversationShow
