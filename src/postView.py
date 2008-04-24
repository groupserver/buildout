from zope.component import getMultiAdapter
from interfaces import IGSPostView
from zope.interface import implements
from zope.component import createObject
from Products.Five import BrowserView
import Products.GSContent, queries, view
from zope.publisher.interfaces import IPublishTraverse

class GSPostTraversal(BrowserView):
    implements(IPublishTraverse)
    def __init__(self, context, request):
        self.context = context
        self.request = request

        self.postId = None
        self.post = None
        
        da = self.context.zsqlalchemy 
        assert da, 'No data-adaptor found'
        self.messageQuery = queries.MessageQuery(self.context, da)
        
    def publishTraverse(self, request, name):
        if not self.postId:
            self.postId = name
            
        return self
    
    def __call__(self):
      return getMultiAdapter((self.context, self.request), name="gspost")()
      
class GSPostView(BrowserView):
      """A view of a single post.
      
      A view of a single post shares much in common with a view of an 
      entire topic, which is why it inherits from "GSTopicView". The main
      semantic difference is the ID specifies post to display, rather than
      the first post in the topic.   
      """
      implements(IGSPostView)
      def __init__(self, context, request):
          self.context = context
          self.request = request

          self.siteInfo = Products.GSContent.view.GSSiteInfo( context )
          self.groupInfo = createObject('groupserver.GroupInfo', context)
          
          self.archive = context.messages
            
          da = self.context.zsqlalchemy 
          assert da, 'No data-adaptor found'
          self.messageQuery = queries.MessageQuery(self.context, da)
          
          self.postId = self.context.postId
          self.post = self.messageQuery.post(self.postId)
          
          if self.post:
              self.relatedPosts = self.messageQuery.topic_post_navigation(self.postId)
          else:
              self.do_error_redirect()
              
      def do_error_redirect(self):
          if not self.postId:
              self.request.response.redirect('/r/post-no-id')
          else:
              self.request.response.redirect('/r/post-not-found?id=%s' % self.postId)
          
      def get_topic_title(self):
          assert hasattr(self, 'post')
          retval = self.post and self.post['subject'] or ''
          return retval
          
      def get_previous_post(self):
          assert hasattr(self, 'relatedPosts')
          assert self.relatedPosts.has_key('previous_post_id')
          return self.relatedPosts['previous_post_id']
                    
      def get_next_post(self):
          assert hasattr(self, 'relatedPosts')
          assert self.relatedPosts.has_key('next_post_id')
          return self.relatedPosts['next_post_id']
          
      def get_first_post(self):
          assert hasattr(self, 'relatedPosts')
          assert self.relatedPosts.has_key('first_post_id')
          return self.relatedPosts['first_post_id']
          
      def get_last_post(self):
          assert hasattr(self, 'relatedPosts')
          assert self.relatedPosts.has_key('last_post_id')
          return self.relatedPosts['last_post_id']
          
      def get_post(self):
          assert hasattr(self, 'post')
          return self.post

