import React from 'react'
import ReactDOM from 'react-dom'
import EditUser from './main/EditUser'
import PicturesIndex from './main/PicturesIndex'
import ConversationsIndex from './main/ConversationsIndex'
import ConversationShow from './main/ConversationShow'
import ActivityFeed from './main/ActivityFeed'

// glue code to find the pricing table div
// and render the PricingTable react component there
document.addEventListener('DOMContentLoaded', () => {
  const users_edit = document.querySelector('#user-edit')
  const pictures_index = document.querySelector('#pictures-index')
  const conversations_index = document.querySelector('#conversations-index')
  const conversation_show = document.querySelector('#conversation-show')
  const activity_feed = document.querySelector('#user-activity-feed')

  if (users_edit) {
    ReactDOM.render(<EditUser/>, users_edit)
  } else if (pictures_index) {
    ReactDOM.render(<PicturesIndex/>, pictures_index)
  } else if (conversations_index) {
    ReactDOM.render(<ConversationsIndex/>, conversations_index)
  } else if (conversation_show) {
    ReactDOM.render(<ConversationShow/>, conversation_show)
  } else if (activity_feed) {
    ReactDOM.render(<ActivityFeed/>, activity_feed)
  }
})
