import React from "react"
import PropTypes from "prop-types"
import Message from "./Message"
class Messages extends React.Component {
  render () {
    return (
      <div>
				{this.props.messages.map(message => (
					<Message
						key={message.id} 
						content={message.content}
						sender={message.sender}
						avatar={message.avatar}
						created_at={message.created_at}
						position={message.position}
						direction={message.direction}
						color={message.color}
					/>
				))}
      </div>
    );
  }
}

Messages.propTypes = {
  messages: PropTypes.array
};

export default Messages
