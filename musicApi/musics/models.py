from django.db import models
from django.utils.translation import gettext as _
from django.contrib.auth import get_user_model
# Create your models here.

class Category(models.Model):
    class Meta:
        verbose_name_plural = _("Categories")

    name = models.CharField(_("Name"), max_length=50)
    description = models.TextField(blank=True, null=True, verbose_name='Category Description')
    slug = models.SlugField(default="",null=False)
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='Created At')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='Updated At')

    def __str__(self) -> str:
        return f"{self.name}"

class Musician(models.Model):
    first_name = models.CharField(_("First Name"), max_length=50)
    last_name = models.CharField(_("Last Name"), max_length=50)
    avatar = models.URLField(_("Avatar"), max_length=500)
    slug = models.SlugField(default="",null=False)
    resume = models.TextField(_("Resume"),blank=True, null=True,)
    category = models.ManyToManyField(Category, verbose_name=_("Category"))

    def __str__(self) -> str:
        return f"{self.first_name} {self.last_name}"

# The `Album` class represents a music album with attributes such as name, slug, artist, release date, and number of
# stars.
class Album(models.Model):
    name = models.CharField(_("Name"), max_length=50)
    slug = models.SlugField(default="",null=False)
    image = models.URLField(_("Image"), max_length=500)
    artist = models.ForeignKey(Musician, verbose_name=_("Artist"), on_delete=models.CASCADE)
    release_date = models.DateField(_("Relase Date"))
    num_stars = models.IntegerField(_("Stars"))

    def __str__(self) -> str:
        return f"{self.name}"

# The Music class represents a music object with various attributes such as name, slug, lyric, artist, category, album,
# music_url, image_url, video_url, release_date, and num_stars.
class Music(models.Model):
    name = models.CharField(_("Name"), max_length=50)
    uploader = models.ForeignKey(get_user_model(), verbose_name=_("Uploader"), on_delete=models.CASCADE)
    slug = models.SlugField(default="",null=False)
    lyric = models.TextField(_("Lyric"),null=True,blank=True)
    artist = models.ForeignKey(Musician, verbose_name=_("Artists"), on_delete=models.CASCADE, related_name="artist")
    feats = models.ManyToManyField(Musician, verbose_name=_("Feats"), blank=True, related_name="feats")
    category = models.ManyToManyField(Category, verbose_name=_("Category"))
    albums = models.ManyToManyField(Album, verbose_name=_("Albums"),blank=True)
    music_url = models.URLField(_("Music Path"), max_length=500,null=True,blank=True)
    image_url = models.URLField(_("Image Path"), max_length=500,null=True,blank=True)
    video_url = models.URLField(_("Video Path"), max_length=500,null=True,blank=True)
    release_date = models.DateField(_("Relase Date"))
    num_stars = models.IntegerField(_("Stars"))

    def __str__(self) -> str:
        return f"{self.name}"

# The `Lists` class represents a model in Django that contains fields for name, slug, description, image, creator, and a
# many-to-many relationship with the `Music` model.
class List(models.Model):
    name = models.CharField(_("Name"), max_length=50)
    slug = models.SlugField(default="",null=False)
    description = models.TextField(_("Description"))
    image = models.ImageField(_("Image"), upload_to='static/images', height_field=None, width_field=None, max_length=None)
    creator = models.ForeignKey(get_user_model(), verbose_name=_("Creator"), on_delete=models.CASCADE,related_name='lists')
    musics = models.ManyToManyField(Music, verbose_name=_("Musics"))

    def __str__(self) -> str:
        return f"{self.name}"



