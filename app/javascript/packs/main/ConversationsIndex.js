import React from 'react'
import axios from 'axios'
import AjaxHelper from './AjaxHelper';

class ConversationsIndex extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      apiRequestHeaders: {},
      user_id: document.querySelector('#user-id').value,
      error: null,
      isLoaded: false,
      conversations: []
    };
  }

  componentDidMount() {
    var path = "/api/users/" + this.state.user_id + "/conversations"
    AjaxHelper(path, this, "conversations");
  }

  render() {
    const { error, isLoaded, conversations } = this.state;
    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
      return (
        <div className="container">
          <h2>Conversations</h2>
          <table className="table">
            <thead>
              <tr>
                <th>From</th>
                <th>To</th>
                <th>Unread Messages</th>
              </tr>
            </thead>
            <tbody>
              {conversations.map(conversation => (
                <tr>
                  <td>{conversation["sender"]["email"]}</td>
                  <td>{conversation["recipient"]["email"]}</td>
                  <td>{conversation["message_count"]}</td>
                  <td><a href={conversation["url"]}>New Message</a></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      );
    }
  }
}

export default ConversationsIndex
